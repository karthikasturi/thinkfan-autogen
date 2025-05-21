#!/bin/bash

# Output file
OUTPUT_FILE="/etc/thinkfan.conf"

# Embedded template content
TEMPLATE_CONTENT="tp_fan /proc/acpi/ibm/fan"

# Temp range map
TEMP_MAP=$(cat <<'EOF'
(0,     0,      50)
(1,     50,     55)
(2,     55,     60)
(3,     60,     65)
(4,     65,     70)
(5,     70,     75)
(6,     75,     80)
(7,     80,     32767)
EOF
)

# Create or clear the output file
> "$OUTPUT_FILE"

# Write the template content
echo "$TEMPLATE_CONTENT" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Find all temp*_input files
sensor_files=$(find /sys/devices -type f -name "temp*_input" 2>/dev/null | sort)

# Append only readable sensor paths, prefixed with 'hwmon'
while read -r line; do
    if cat "$line" > /dev/null 2>&1; then
        echo "hwmon $line" >> "$OUTPUT_FILE"
    fi
done <<< "$sensor_files"

# Add an empty line
echo "" >> "$OUTPUT_FILE"

# Append the temperature map
echo "$TEMP_MAP" >> "$OUTPUT_FILE"

echo "Generated $OUTPUT_FILE"

