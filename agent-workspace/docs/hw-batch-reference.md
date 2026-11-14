# Hades Workshop batch-mode reference (agent-cli fork)

Generated from Source/main_command.cpp. Index names go with `select`; field names with `get`/`set`.
A field `a.b.c` needs every index on its path selected: `select a N`, then `select a.b M`, then `get a.b.c`.

## Index names (select INDEX VALUE; VALUE -1 unselects)

`battle`, `field`, `world` and `text_block` take the game's **ID** (e.g. a field ID), not a 0-based position.
All other indices are 0-based positions. To list the IDs that exist, export one field of that structure,
e.g. `export data spreadsheet out/battles.csv battle.flag`; the first column is the ID.

| index | load section |
|---|---|
| `spell` | `spell` |
| `status_set` | `spell` |
| `support` | `support` |
| `command` | `command` |
| `stat` | `stat` |
| `initial_equip` | `stat` |
| `ability_list` | `stat` |
| `command_list` | `stat` |
| `level` | `stat` |
| `magic_sword` | `party_special` |
| `item` | `item` |
| `item_stat` | `item` |
| `key_item` | `item` |
| `shop` | `shop` |
| `synthesis` | `shop` |
| `deck` | `card` |
| `card_set` | `card` |
| `card` | `card` |
| `spell_animation` | `spell_animation` |
| `battle` | `battle` |
| `field` | `field` |
| `world` | `world` |
| `text_block` | `text` |
| `command.spell` | `command` |
| `ability_list.slot` | `stat` |
| `item.skillslot` | `item` |
| `shop.slot` | `shop` |
| `card_set.slot` | `card` |
| `spell_animation.code` | `spell_animation` |
| `spell_animation.code.arg` | `spell_animation` |
| `battle.animation` | `battle` |
| `battle.camera_raw` | `battle` |
| `battle.group` | `battle` |
| `battle.group.slot` | `battle` |
| `battle.enemy` | `battle` |
| `battle.enemy.item` | `battle` |
| `battle.enemy.selection` | `battle` |
| `battle.attack` | `battle` |
| `field.triangle` | `field` |
| `field.edge` | `field` |
| `field.walkpath` | `field` |
| `field.normal` | `field` |
| `field.vertex` | `field` |
| `field.tile_anim` | `field` |
| `field.tile_anim.tile` | `field` |
| `field.tile_block` | `field` |
| `field.tile_block.tile` | `field` |
| `field.camera` | `field` |
| `world_place` | `world` |
| `world_place.raw` | `world` |
| `world_spot` | `world` |
| `world_spot.battle` | `world` |
| `world_friendly` | `world` |
| `world_friendly.spot` | `world` |
| `text_block.slot` | `text` |
| `text_block.charmap_glyph` | `text` |

## Field names (get / set)

Fields marked (text) are strings: write them in quotes; inside, use `[NEWLINE]` for a line break and `[QUOTE]` for a double quote. All other fields are integers.

- **spell**: name (text), help (text), target_type, model, target_flag, effect, power, element, accuracy, flag, status, mp, menu_flag, model_alt, help_size_x, perform_name
- **status_set**: status
- **support**: name (text), help (text), help_size_x, category, cost
- **command**: name (text), help (text), panel, spell_amount, help_size_x, link
- **command.spell**: spell_list
- **stat**: default_name (text), default_name_size_x, speed, strength, magic, spirit, magic_stone
- **initial_equip**: weapon, head, wrist, armor, accessory
- **ability_list.slot**: ability, ap_cost
- **command_list**: first_command, second_command, first_command_trance, second_command_trance, trance_attack
- **level**: hp_table, mp_table, exp_table
- **item**: name (text), help (text), battle_help (text), price, char_availability, icon, icon_color, equip_position, stat_id, type, menu_position, target_type, model, target_flag, effect, power, element, accuracy, status, flag, weapon_status, model, damage_formula, weapon_power, weapon_element, status_accuracy, offset1, offset2, defence, evade, magic_defence, magic_evade
- **item.skillslot**: skill
- **item_stat**: speed, strength, magic, spirit, element_immune, element_absorb, element_half, element_weak, element_boost
- **key_item**: name (text), help (text), description (text), help_size_x
- **shop**: item_amount
- **shop.slot**: item
- **synthesis**: price, recipe1, recipe2, synthesized, shops
- **card**: name (text), name_size_x, player_attack, player_type, player_defence, player_magicdefence, npc_attack, npc_type, npc_defence, npc_magicdefence, points
- **card_set.slot**: card
- **deck**: set, difficulty
- **spell_animation.code**: opcode
- **spell_animation.code.arg**: value
- **battle**: flag
- **battle.group**: frequence, enemy_amount, camera_engage, ap
- **battle.group.slot**: enemy_id, targetable, enemy_posx, enemy_posz, enemy_posy, enemy_angle
- **battle.enemy**: name (text), lvl, classification, hp, mp, gils, exp, card_drop, attack, accuracy, cur_capa, max_capa, trans, speed, strength, magic, spirit, defence, evade, magic_defence, magic_evade, element_immune, element_absorb, element_half, element_weak, status_immune, status_auto, status_initial, default_attack, blue_magic, death_flag, text_amount, radius, model, anim_idle, anim_idle_alt, anim_hit, anim_hit_alt, anim_death, anim_death_alt, mesh, mesh_vanish, bone_camera1, bone_camera2, bone_camera3, bone_target, shadow_size_x, shadow_size_y, shadow_bone1, shadow_bone2, shadow_offset_x, shadow_offset_y, sound_engage, sound_death, zerostat, zero1, zero2, zero3
- **battle.enemy.selection**: selection_bone, selection_offsetz, selection_offsety
- **battle.enemy.item**: item_drop, item_steal
- **battle.attack**: name (text), effect, power, element, accuracy, flag, status, mp, model, target_type, target_flag, menu_flag, model_alt, name_offset
- **battle.animation**: id
- **battle.camera_raw**: byte
- **field**: walkmesh_orgx, walkmesh_orgz, walkmesh_orgy, walkmesh_x, walkmesh_z, walkmesh_y, walkmesh_minx, walkmesh_minz, walkmesh_miny, walkmesh_maxx, walkmesh_maxz, walkmesh_maxy, walkmesh_charx, walkmesh_charz, walkmesh_chary, walkmesh_active_walkpath, walkmesh_active_triangle, tile_depth_shift, default_depth, depth, default_x, default_y, pos_x, pos_y, min_x, max_x, min_y, max_y, screen_x, screen_y
- **field.triangle**: flag, data, normal, thetax, thetay, centerx, centerz, centery, d
- **field.edge**: flag
- **field.walkpath**: flag, id, orgx, orgz, orgy, offsetx, offsetz, offsety, minx, minz, miny, maxx, maxz, maxy
- **field.normal**: x, z, y, overz
- **field.vertex**: x, z, y
- **field.tile_anim**: flag, camera_id, default_frame, rate, counter
- **field.tile_anim.tile**: tile_index, duration
- **field.tile_block**: width, height, default_x, default_y, pos_x, pos_y, pos_minx, pos_maxx, pos_miny, pos_maxy, screen_x, screen_y, pos_dx, pos_dy, pos_fracx, pos_fracy, camera_id, tile_tpage, is_screen_static, use_attaching, is_looping, has_parallax, is_static, is_scroll_with_offset, depth, default_depth, is_x_offset, viewport_id
- **field.tile_block.tile**: depth, pos_y, pos_x, clut_y, clut_x, page_y, page_x, res, alpha, source_v, source_u, h, w, trans
- **field.camera**: distance, matrix_xx, matrix_xy, matrix_xz, matrix_yx, matrix_yy, matrix_yz, matrix_zx, matrix_zy, matrix_zz, offset_x, offset_z, offset_y, offset_centerx, offset_centery, offset_width, offset_height, min_x, max_x, min_y, max_y, depth, pos_x, pos_y, width, height
- **world_place**: name (text)
- **world_place.raw**: byte
- **world_spot**: flag
- **world_spot.battle**: id
- **world_friendly.spot**: area
- **text_block.slot**: text (text)
- **text_block**: charmap_unknown1, charmap_unknown2, charmap_unknown3, charmap_unknown4
- **text_block.charmap_glyph**: img_x, img_y, img_width, width
