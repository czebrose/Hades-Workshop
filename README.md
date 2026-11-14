# Hades-Workshop
Final Fantasy IX modding tool

Main webpage about the tool: https://forums.qhimm.com/index.php?topic=14315.0

Note from Tirlititi: I retire from modding. I will unlikely update the tool anymore.
I am still available for answering questions, regarding HW or FF9 modding.

## Batch / headless mode (agent-cli fork)

Run a command file without any window:

    Hades-Workshop.exe -q -i commands.txt -o log.txt

- `-q` / `--headless`: no window or progress popup; output goes to `log.txt` (if `-o` is given) and to stdout; the program exits when the file is done.
- Exit code: `0` success, `1` at least one error, `2` warnings only. The last line of output is `finished: N error(s), M warning(s)`.
- Run `help` in a command file to list commands; `help field_name` / `help index_name` list the editable fields and selectors.
- Reading data: `get FIELDNAME` prints one value for the current `select`ion; `export data spreadsheet FILE PREFIX` dumps a table; `export data reimport FILE PREFIX` dumps `select`/`set` lines that can be edited and run back in.
- From `cmd.exe`, use `start /wait` (it doesn't wait for GUI programs); bash and PowerShell's `Start-Process -Wait` do wait.
