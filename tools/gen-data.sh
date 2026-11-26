#!/usr/bin/env bash
set -euo pipefail
R=src/main/resources
mkdir -p $R/assets/brutalicious/lang \
  $R/data/brutalicious/worldgen/biome \
  $R/data/brutalicious/worldgen/world_preset \
  $R/data/brutalicious/dimension \
  $R/data/brutalicious/dimension_type \
  $R/data/brutalicious/tags/worldgen/biome \
  $R/data/minecraft/tags/worldgen/world_preset \
  $R/data/minecraft/tags/worldgen/biome/has_structure

mk_biome() {
  cat > "$R/data/brutalicious/worldgen/biome/$1.json" <<EOF
{
  "has_precipitation": true,
  "temperature": ${11},
  "downfall": 0.6,
  "effects": {
    "fog_color": $2,
    "sky_color": $3,
    "water_color": 4740694,
    "water_fog_color": $4,
    "grass_color": 7303023,
    "foliage_color": 6710886,
    "particle": { "options": { "type": "$5" }, "probability": $6 },
    "ambient_sound": "$7",
    "mood_sound": { "sound": "$8", "tick_delay": 3000, "block_search_extent": 8, "offset": 2.0 },
    "additions_sound": { "sound": "$9", "tick_chance": 0.0071 },
    "music": { "sound": "${12}", "min_delay": 6000, "max_delay": 18000, "replace_current_music": false }
  },
  "spawners": {
    "monster": ${10},
    "creature": ${13:-[]},
    "ambient": [ { "type": "minecraft:bat", "weight": 10, "minCount": 2, "maxCount": 4 } ],
    "axolotls": [],
    "underground_water_creature": [],
    "water_creature": [],
    "water_ambient": [],
    "misc": []
  },
  "spawn_costs": {},
  "carvers": {},
  "features": []
}
EOF
}

SURF='[
      { "type": "minecraft:zombie", "weight": 100, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:zombie_villager", "weight": 25, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:skeleton", "weight": 80, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:spider", "weight": 70, "minCount": 2, "maxCount": 3 },
      { "type": "minecraft:creeper", "weight": 70, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 25, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:witch", "weight": 8, "minCount": 1, "maxCount": 1 }
    ]'
MONO='[
      { "type": "minecraft:zombie", "weight": 60, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:husk", "weight": 40, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:skeleton", "weight": 60, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:stray", "weight": 30, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:spider", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:creeper", "weight": 60, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:witch", "weight": 10, "minCount": 1, "maxCount": 1 }
    ]'
UNDER='[
      { "type": "minecraft:zombie", "weight": 90, "minCount": 2, "maxCount": 5 },
      { "type": "minecraft:skeleton", "weight": 70, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:cave_spider", "weight": 40, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:spider", "weight": 40, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:creeper", "weight": 50, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:silverfish", "weight": 20, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:enderman", "weight": 15, "minCount": 1, "maxCount": 1 }
    ]'
WET='[
      { "type": "minecraft:drowned", "weight": 80, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:zombie", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:skeleton", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:spider", "weight": 30, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 20, "minCount": 1, "maxCount": 2 }
    ]'
DEEP='[
      { "type": "minecraft:zombie", "weight": 60, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:drowned", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:skeleton", "weight": 60, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:creeper", "weight": 40, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 30, "minCount": 1, "maxCount": 2 }
    ]'

mk_biome concrete_sprawl   11053742 10530215 3355443 minecraft:white_ash 0.002 minecraft:ambient.basalt_deltas.loop  minecraft:ambient.cave                 minecraft:ambient.soul_sand_valley.additions "$SURF" -0.5 minecraft:music.overworld.snowy_slopes
mk_biome monolith_district 7302526 8028036 2236962 minecraft:white_ash 0.004 minecraft:ambient.soul_sand_valley.loop minecraft:ambient.soul_sand_valley.mood minecraft:ambient.soul_sand_valley.additions "$MONO" -0.5 minecraft:music.overworld.frozen_peaks
mk_biome undercroft        1315860 1315860 1315860 minecraft:white_ash 0.004 minecraft:ambient.basalt_deltas.loop  minecraft:ambient.cave                 minecraft:ambient.basalt_deltas.additions   "$UNDER" 0.4 minecraft:music.overworld.deep_dark
mk_biome cistern            657930  657930 1052688 minecraft:mycelium  0.02  minecraft:ambient.underwater.loop     minecraft:ambient.soul_sand_valley.mood minecraft:ambient.underwater.loop.additions.ultra_rare "$DEEP" 0.4 minecraft:music.overworld.deep_dark
SETTLE='[
      { "type": "minecraft:zombie", "weight": 40, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:skeleton", "weight": 30, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:spider", "weight": 20, "minCount": 1, "maxCount": 1 }
    ]'
FARM='[
      { "type": "minecraft:chicken", "weight": 10, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:sheep", "weight": 8, "minCount": 2, "maxCount": 3 },
      { "type": "minecraft:rabbit", "weight": 6, "minCount": 2, "maxCount": 3 }
    ]'
mk_biome settlement        9474964 9937574 3355443 minecraft:white_ash 0.001 minecraft:ambient.basalt_deltas.loop  minecraft:ambient.cave                 minecraft:ambient.soul_sand_valley.additions "$SETTLE" 0.2 minecraft:music.overworld.snowy_slopes "$FARM"
mk_biome reservoir         5596511 6056802 2302755 minecraft:white_ash 0.001 minecraft:ambient.underwater.loop     minecraft:ambient.cave                 minecraft:ambient.basalt_deltas.additions   "$WET" 0.6 minecraft:music.overworld.snowy_slopes

BLACK='[
      { "type": "minecraft:zombie", "weight": 100, "minCount": 2, "maxCount": 5 },
      { "type": "minecraft:skeleton", "weight": 80, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:spider", "weight": 60, "minCount": 2, "maxCount": 3 },
      { "type": "minecraft:cave_spider", "weight": 30, "minCount": 2, "maxCount": 4 },
      { "type": "minecraft:creeper", "weight": 60, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 40, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:silverfish", "weight": 15, "minCount": 2, "maxCount": 4 }
    ]'
ASH='[
      { "type": "minecraft:husk", "weight": 70, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:zombie", "weight": 50, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:stray", "weight": 60, "minCount": 1, "maxCount": 3 },
      { "type": "minecraft:skeleton", "weight": 30, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:spider", "weight": 30, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:creeper", "weight": 40, "minCount": 1, "maxCount": 2 },
      { "type": "minecraft:enderman", "weight": 30, "minCount": 1, "maxCount": 2 }
    ]'
mk_biome blackout           526344  526344  526344 minecraft:ash       0.008 minecraft:ambient.soul_sand_valley.loop minecraft:ambient.cave             minecraft:ambient.soul_sand_valley.additions "$BLACK" 0.4 minecraft:music.overworld.deep_dark
mk_biome exclusion_zone    8421504 8947848 3355443 minecraft:white_ash 0.02  minecraft:ambient.basalt_deltas.loop  minecraft:ambient.soul_sand_valley.mood minecraft:ambient.basalt_deltas.additions "$ASH" -0.5 minecraft:music.overworld.frozen_peaks

GEN='{
        "type": "brutalicious:city",
        "biome_source": {
          "type": "brutalicious:city",
          "sprawl": "brutalicious:concrete_sprawl",
          "monolith": "brutalicious:monolith_district",
          "undercroft": "brutalicious:undercroft",
          "cistern": "brutalicious:cistern",
          "reservoir": "brutalicious:reservoir",
          "settlement": "brutalicious:settlement",
          "blackout": "brutalicious:blackout",
          "exclusion": "brutalicious:exclusion_zone"
        }
      }'

cat > $R/data/brutalicious/worldgen/world_preset/brutalist_city.json <<EOF
{
  "dimensions": {
    "minecraft:overworld": {
      "type": "brutalicious:megacity",
      "generator": $GEN
    },
    "minecraft:the_nether": {
      "type": "minecraft:the_nether",
      "generator": { "type": "minecraft:noise", "settings": "minecraft:nether", "biome_source": { "type": "minecraft:multi_noise", "preset": "minecraft:nether" } }
    },
    "minecraft:the_end": {
      "type": "minecraft:the_end",
      "generator": { "type": "minecraft:noise", "settings": "minecraft:end", "biome_source": { "type": "minecraft:the_end" } }
    }
  }
}
EOF

cat > $R/data/brutalicious/dimension/the_city.json <<EOF
{
  "type": "brutalicious:eternal_night",
  "generator": $GEN
}
EOF

cat > $R/data/brutalicious/dimension_type/eternal_night.json <<'EOF'
{
  "ultrawarm": false,
  "natural": true,
  "coordinate_scale": 1.0,
  "has_skylight": true,
  "has_ceiling": false,
  "ambient_light": 0.0,
  "fixed_time": 18000,
  "monster_spawn_light_level": { "type": "minecraft:uniform", "min_inclusive": 0, "max_inclusive": 7 },
  "monster_spawn_block_light_limit": 0,
  "piglin_safe": false,
  "bed_works": true,
  "respawn_anchor_works": false,
  "has_raids": false,
  "logical_height": 512,
  "min_y": -64,
  "height": 512,
  "infiniburn": "#minecraft:infiniburn_overworld",
  "effects": "minecraft:overworld"
}
EOF

sed -e '/"fixed_time"/d' $R/data/brutalicious/dimension_type/eternal_night.json > $R/data/brutalicious/dimension_type/megacity.json

P=$R/data/brutalicious/worldgen/world_preset
sed 's/"type": "brutalicious:megacity",/"type": "brutalicious:eternal_night",/' $P/brutalist_city.json > $P/brutalist_city_night.json

cat > $R/data/minecraft/tags/worldgen/world_preset/normal.json <<'EOF'
{ "replace": false, "values": ["brutalicious:brutalist_city", "brutalicious:brutalist_city_night"] }
EOF
cat > $R/data/brutalicious/tags/worldgen/biome/city.json <<'EOF'
{ "values": ["brutalicious:concrete_sprawl", "brutalicious:monolith_district", "brutalicious:undercroft", "brutalicious:cistern", "brutalicious:reservoir", "brutalicious:settlement", "brutalicious:blackout", "brutalicious:exclusion_zone"] }
EOF
cat > $R/data/minecraft/tags/worldgen/biome/has_structure/stronghold.json <<'EOF'
{ "replace": false, "values": ["brutalicious:undercroft", "brutalicious:cistern"] }
EOF
echo "data generated"
