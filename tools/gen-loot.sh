#!/usr/bin/env bash
set -euo pipefail
OUT=src/main/resources/data/brutalicious/loot_table/chests
mkdir -p "$OUT"

table() {
  local name=$1 a=$2 b=$3
  awk -v a="$a" -v b="$b" '
    $1 == "empty" { e[n++] = sprintf("        { \"type\": \"minecraft:empty\", \"weight\": %s }", $2); next }
    NF >= 4 {
      f = sprintf("{ \"function\": \"minecraft:set_count\", \"count\": { \"type\": \"minecraft:uniform\", \"min\": %s, \"max\": %s } }", $3, $4)
      if ($5 == "worn") f = f ", { \"function\": \"minecraft:set_damage\", \"damage\": { \"type\": \"minecraft:uniform\", \"min\": 0.05, \"max\": 0.4 } }"
      if ($5 == "enchant") f = f ", { \"function\": \"minecraft:enchant_randomly\" }"
      e[n++] = sprintf("        { \"type\": \"minecraft:item\", \"name\": \"minecraft:%s\", \"weight\": %s, \"functions\": [ %s ] }", $1, $2, f)
    }
    END {
      print "{\n  \"type\": \"minecraft:chest\",\n  \"pools\": [\n    {\n      \"rolls\": { \"type\": \"minecraft:uniform\", \"min\": " a ", \"max\": " b " },\n      \"entries\": ["
      for (i = 0; i < n; i++) print e[i] (i < n - 1 ? "," : "")
      print "      ]\n    }\n  ]\n}"
    }' > "$OUT/$name.json"
}

table apartment 1 3 <<'EOF'
empty 30
rotten_flesh 14 1 3
bone 10 1 3
paper 10 1 4
string 8 1 2
stick 8 1 3
glass_bottle 6 1 2
bowl 4 1 1
candle 4 1 2
iron_nugget 4 1 3
bread 3 1 1
potato 3 1 2
wheat_seeds 2 1 3
EOF

table office 1 3 <<'EOF'
empty 30
paper 16 2 6
book 4 1 1
ink_sac 4 1 1
redstone 4 1 3
iron_nugget 5 1 4
glass_bottle 4 1 1
compass 1 1 1
map 2 1 1
stick 6 1 2
EOF

table archive 1 3 <<'EOF'
empty 22
paper 18 2 8
book 8 1 2
writable_book 2 1 1
leather 3 1 1
gold_nugget 4 1 4
iron_nugget 4 1 4
experience_bottle 2 1 1
name_tag 1 1 1
emerald 1 1 1
EOF

table tunnel 1 3 <<'EOF'
empty 26
coal 10 1 4
rail 6 1 4
iron_nugget 8 1 4
copper_ingot 4 1 2
torch 6 1 3
rotten_flesh 8 1 2
string 4 1 2
stone_pickaxe 2 1 1 worn
iron_pickaxe 1 1 1 worn
EOF

table camp 1 3 <<'EOF'
empty 22
stick 10 1 4
coal 6 1 2
string 6 1 2
bread 4 1 1
dried_kelp 5 1 4
baked_potato 3 1 2
torch 5 1 3
flint 4 1 2
white_wool 3 1 1
bowl 4 1 1
flint_and_steel 1 1 1 worn
EOF

table military 1 3 <<'EOF'
empty 24
arrow 10 1 6
gunpowder 6 1 2
string 4 1 2
leather 4 1 1
iron_nugget 6 1 5
bread 2 1 1
iron_helmet 1 1 1 worn
iron_boots 1 1 1 worn
crossbow 1 1 1 worn
shield 1 1 1 worn
spyglass 1 1 1
EOF

table hospital 1 3 <<'EOF'
empty 26
glass_bottle 14 1 3
paper 8 1 3
sugar 4 1 2
spider_eye 4 1 1
white_wool 4 1 2
honey_bottle 1 1 1
golden_carrot 1 1 1
glistering_melon_slice 1 1 1
EOF

table industrial 1 3 <<'EOF'
empty 24
iron_nugget 12 1 6
coal 10 1 4
copper_ingot 6 1 3
redstone 5 1 3
chain 4 1 2
rail 4 1 3
flint 4 1 2
iron_ingot 2 1 1
bucket 1 1 1
shears 1 1 1 worn
EOF

table farm 1 4 <<'EOF'
empty 12
wheat_seeds 12 1 4
beetroot_seeds 6 1 3
potato 8 1 3
carrot 6 1 2
wheat 6 1 3
bone_meal 6 1 4
bread 4 1 2
oak_sapling 3 1 1
spruce_sapling 2 1 1
bucket 1 1 1
iron_hoe 1 1 1 worn
EOF

table cistern 3 6 <<'EOF'
gold_ingot 8 2 5
iron_ingot 8 2 6
diamond 5 1 3
emerald 6 2 5
echo_shard 4 1 3
experience_bottle 6 2 6
golden_apple 3 1 2
book 5 1 1 enchant
iron_sword 2 1 1 enchant
disc_fragment_5 2 1 2
amethyst_shard 5 2 6
recovery_compass 1 1 1
enchanted_golden_apple 1 1 1
EOF

table deep_works 3 6 <<'EOF'
iron_ingot 10 2 8
gold_ingot 8 2 6
redstone 8 4 12
diamond 6 1 3
emerald 6 2 6
netherite_scrap 2 1 1
experience_bottle 6 2 6
book 6 1 1 enchant
diamond_pickaxe 2 1 1 enchant
iron_chestplate 2 1 1 enchant
golden_apple 4 1 2
totem_of_undying 1 1 1
ender_pearl 4 1 3
EOF

table vault 4 7 <<'EOF'
diamond 10 2 5
emerald 8 3 8
gold_block 3 1 2
netherite_scrap 4 1 2
book 8 1 1 enchant
diamond_sword 3 1 1 enchant
diamond_chestplate 2 1 1 enchant
enchanted_golden_apple 2 1 1
totem_of_undying 2 1 1
echo_shard 5 2 4
experience_bottle 6 4 10
music_disc_otherside 1 1 1
EOF

table footings 4 8 <<'EOF'
diamond 10 2 6
netherite_scrap 6 1 3
ancient_debris 3 1 2
emerald 6 3 8
gold_block 3 1 2
book 8 1 1 enchant
diamond_pickaxe 2 1 1 enchant
diamond_helmet 2 1 1 enchant
diamond_leggings 2 1 1 enchant
enchanted_golden_apple 2 1 1
totem_of_undying 2 1 1
echo_shard 5 2 5
experience_bottle 6 4 12
music_disc_5 1 1 1
EOF

table seed_vault 3 6 <<'EOF'
wheat_seeds 12 2 6
beetroot_seeds 8 1 4
melon_seeds 5 1 3
pumpkin_seeds 5 1 3
carrot 6 1 3
potato 6 1 3
oak_sapling 4 1 2
spruce_sapling 4 1 2
birch_sapling 3 1 2
sweet_berries 3 1 3
bone_meal 6 2 6
sugar_cane 2 1 2
EOF

echo "loot tables written to $OUT"
