#!/bin/sh

COMPILE=true

if [ "$COMPILE" = true ]
then
  sudo apt-get install texlive texlive-publishers texlive-science texlive-lang-czechslovak cm-super latexmk

  CURRENT_PATH=$(pwd)
  
  for DIRECTORY in */; do
    if [ -d "$DIRECTORY" ] && [ "$DIRECTORY" != "Assets/" ]; then
        cd "$DIRECTORY" || continue
        TEX_FILE=$(find . -name "*.tex" -maxdepth 1)
        if [ -n "$TEX_FILE" ]; then
            lualatex --synctex=0 --interaction=nonstopmode --aux-directory=aux "$TEX_FILE" > out.log
            lualatex --synctex=0 --interaction=nonstopmode --aux-directory=aux "$TEX_FILE" > out.log
            lualatex --synctex=0 --interaction=nonstopmode --aux-directory=aux "$TEX_FILE" > out.log
        else
            echo "No LaTeX file found, exit."
        fi
        cd "$CURRENT_PATH"
    fi
    done

    mkdir -p releases
    for DIRECTORY in */; do
    if [ -d "$DIRECTORY" ]; then
        # Přejdi do adresáře
        cd "$DIRECTORY" || continue

        # Najdi všechny PDF soubory v aktuálním adresáři
        PDF_FILES=(*.pdf)

        # Pokud byly nalezeny PDF soubory
        if [ ${#PDF_FILES[@]} -gt 0 ]; then
            # Přejmenuj PDF soubory a přesuň je do složky ~/releases/
            for PDF_FILE in "${PDF_FILES[@]}"; do
                NEW_FILENAME="${DIRECTORY%/}.pdf"  # Nový název souboru bude jméno složky s příponou .pdf
                mv "$PDF_FILE" ~/assets/"$NEW_FILENAME"
                echo "Přejmenováno a přesunuto: $PDF_FILE -> ~/releases/$NEW_FILENAME"
            done
        fi
    fi
    cd "$CURRENT_PATH"
done
  
fi