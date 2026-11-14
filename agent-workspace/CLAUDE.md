# FF9 modding workspace

This folder builds a Final Fantasy IX (Steam, with Memoria) mod using **Hades Workshop** (HW) in
headless batch mode. HW reads the game's data, applies changes written as text commands, and writes
a Memoria mod folder. You drive it entirely from the shell; never ask the user to click through HW.

HW build: the `agent-cli` branch of https://github.com/czebrose/Hades-Workshop (adds `get`,
headless `-q` mode and exit codes). Its cloud build has no FBX support, so 3D model import/export
is unavailable; the user does that in the official HW GUI if ever needed.

## Layout

| Path | What it is |
|---|---|
| `mod.conf` | Paths: HW exe, FF9 launcher, mod output folder (`MOD_DIR`) |
| `tools/HadesWorkshop/` | `HadesWorkshop.exe` + wxWidgets DLLs |
| `tools/hw.sh` | Run ad-hoc commands against the **unmodified** game (queries, exports) |
| `tools/build.sh` | Rebuild the whole mod from `src/` into `MOD_DIR` |
| `src/*.txt` | **Source of truth**: every change the mod makes, as HW commands |
| `out/` | Exports for reading/editing (dumps, scripts, text) |
| `build/` | Generated command files and logs; never edit by hand |
| `docs/hw-batch-reference.md` | Every `select` index and `get`/`set` field name |

## Running HW

```
HadesWorkshop.exe -q -i commands.txt -o log.txt
```
`-q` = no window; output goes to the log file **and** stdout; the process exits when done.
Relative paths (in arguments and inside command files) are resolved from the current directory.
Use the wrappers instead of calling the exe directly; they add the `open` line and print the log.

**Exit code:** `0` success, `1` at least one error, `2` warnings only. The last output line is
always `finished: N error(s), M warning(s)`. Problems appear as `Error L<n>: ...` /
`Warning L<n>: ...` where `<n>` is the line in the command file that was run. By default a
warning or error **stops** the run at that line, so later lines did not happen. Always check the
exit code and read the log before claiming something worked.

## Command language

One command per line; `#` or `//` starts a comment line; arguments containing spaces go in
double quotes.

| Command | Use |
|---|---|
| `open "PATH\FF9_Launcher.exe"` | Open the game (the wrappers do this) |
| `config auto_load true` | Load sections automatically when needed (the wrappers do this) |
| `load SECTION...` | Load explicitly: `spell support command stat party_special battle item shop card text world field battle_scene spell_animation interface assembly` (`battle_scene` is PSX-only) |
| `select INDEX VALUE` | Choose which entry later `get`/`set` act on; `-1` clears it |
| `get FIELD` | Print one value: `spell.power = 20`, text as `spell.name = "Fire"` |
| `set FIELD VALUE` | Change one value; HW echoes the value it stored |
| `export data spreadsheet FILE PREFIX...` | Table (`;`-separated, first column = index/ID) of every entry for the given field prefixes |
| `export data reimport FILE PREFIX...` | Same data as `select`/`set` lines; edit and run them back in |
| `export text FILE [TEXTBLOCKID...]` / `import text FILE` | Dialogue/text blocks |
| `export uitext FILE [ID...]` / `import uitext FILE` | Menu/UI texts |
| `export script field\|battle\|world FILE [ID...]` / `import script FILE` | Event/AI scripts as editable text; import compiles them back |
| `export hws FILE [SECTIONS]` / `import hws FILE [SECTIONS]` | HW's own patch format (rarely needed here) |
| `save steam FOLDER csv asset [SECTIONS]` | Write the Memoria mod folder (`tools/build.sh` does this) |
| `help`, `help index_name`, `help field_name` | List commands / index names / field names |

Text values: quote them; inside, use `[NEWLINE]` for a line break and `[QUOTE]` for `"`.

**Selecting:** a field `a.b.c` needs each level of its path selected first:
```
select battle 1         # battle, field, world, text_block take the game's ID
select battle.enemy 0   # everything else is a 0-based position
get battle.enemy.hp
```
Field names and which index each needs: `docs/hw-batch-reference.md` (or `help field_name`).
Several fields are bit flags or ID references (element, status, flag, target_*, model...):
read the current value and neighbouring entries before writing a raw number.

## Workflows

**Look something up** (never needs a build):
```
tools/hw.sh <<'EOF'
select item 1
get item.name
get item.price
EOF
```

**Find the right entry or survey a structure:** dump it, then search the file.
```
tools/hw.sh <<'EOF'
export data spreadsheet out/spells.csv spell
EOF
```
Prefer narrow prefixes (`spell.name spell.power`, not `field`): whole field/battle dumps are huge.

**Change data:** put the commands in a change file under `src/`, grouped by topic
(e.g. `src/10-spells.txt`, `src/20-shops.txt`, `src/50-field-scripts.txt`). Files run in name
order. A change file contains only commands, without `open` or `save`. To edit many values,
generate the starting lines with `export data reimport out/x.txt PREFIX`, copy only the lines you
change (each with the `select` lines above it) into `src/`, then edit.

**Edit scripts or text:** export to `out/`, copy the parts you change into `src/` (e.g.
`src/scripts/field_100.txt`), and add an `import script src/scripts/field_100.txt` (or
`import text ...`) line to a change file. Export first to learn the exact format; keep the
headers the export wrote.

**Build:** `tools/build.sh`. It always rebuilds from the unmodified game plus **all** of `src/`,
because HW never reads the existing mod folder. A one-off `save steam` run would replace the mod
with only that run's changes. Never do that.

**Verify:** re-read changed values by running the change file plus `get` lines:
```
{ cat src/10-spells.txt; echo "get spell.power"; } | tools/hw.sh
```
or check the files the build wrote under `MOD_DIR`. Whether it plays correctly in game can only be tested by the
user: say what to check and where.

## Rules

- Never write into the game folder except through `save steam` into `MOD_DIR`; never touch the
  game's own files (`StreamingAssets`, `x64/FF9_Data`, `FF9_Launcher.exe`, Memoria files).
- Keep the default stop-on-warning behaviour. Don't add `config warning_stop false` /
  `config error_stop false` to make a run "pass"; fix the cause.
- `src/` is the mod. Anything not in `src/` is not in the mod after the next build.
- After a failed run, fix the command at the reported line and re-run; don't guess values.
- The mod is loaded by Memoria only if `MOD_DIR`'s folder name is in Memoria's mod list
  (`Memoria.ini`, `[Mod]` section, `FolderNames`). If changes don't show up in game, check that first.
