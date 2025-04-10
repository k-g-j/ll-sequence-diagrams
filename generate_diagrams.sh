#!/bin/bash

# Script to generate all PlantUML diagrams
# Requires: PlantUML, Java, and optionally ImageMagick for resizing

set -e

echo "Generating diagrams from PlantUML files..."

# Create output directories if they don't exist
mkdir -p custom-diagrams/diagrams

# Check if plantuml.jar exists, if not download it
if [ ! -f plantuml.jar ]; then
  echo "Downloading PlantUML..."
  curl -L https://github.com/plantuml/plantuml/releases/download/v1.2024.1/plantuml-1.2024.1.jar -o plantuml.jar
fi

# Generate diagrams for all .puml files in plantuml-diagrams directory
for puml_file in plantuml-diagrams/*.puml; do
  basename=$(basename "$puml_file" .puml)
  echo "Generating diagram for $basename..."
  
  # Generate PNG
  java -jar plantuml.jar -tpng "$puml_file" -o "../custom-diagrams/diagrams"
  
  # Generate SVG
  java -jar plantuml.jar -tsvg "$puml_file" -o "../custom-diagrams/diagrams"
  
  echo "Generated custom-diagrams/diagrams/$basename.png and custom-diagrams/diagrams/$basename.svg"
done

echo "Creating resized versions of architecture diagrams..."

# Check if ImageMagick is installed
if command -v convert >/dev/null 2>&1; then
  # Resize architecture diagrams for better display in markdown
  convert "custom-diagrams/diagrams/atlas-architecture.png" -resize 900x "custom-diagrams/diagrams/atlas-architecture-resized.png"
  convert "custom-diagrams/diagrams/avs-architecture.png" -resize 900x "custom-diagrams/diagrams/avs-architecture-resized.png"
  echo "Resized architecture diagrams"
else
  echo "ImageMagick not found, skipping resize step. Install it with 'brew install imagemagick' if needed."
  # Copy the files instead as a fallback
  cp "custom-diagrams/diagrams/atlas-architecture.png" "custom-diagrams/diagrams/atlas-architecture-resized.png"
  cp "custom-diagrams/diagrams/avs-architecture.png" "custom-diagrams/diagrams/avs-architecture-resized.png"
fi

echo "Updating markdown files to reference new diagrams..."

# Update atlas-app-sequence-diagram.md if needed
sed -i '' 's|custom-diagrams/v[34]/|custom-diagrams/diagrams/|g' atlas-app-sequence-diagram.md

# Update evaluation-avs-sequence-diagram.md if needed
sed -i '' 's|custom-diagrams/v[34]/|custom-diagrams/diagrams/|g' evaluation-avs-sequence-diagram.md

echo "All diagrams generated successfully!"
echo "View them in the custom-diagrams/diagrams/ directory"