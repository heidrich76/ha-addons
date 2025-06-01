# Artwork for MEGAcmd Add-on

Building process for creating `png` files from `svg`:

```sh
docker run --rm -it -v .:/src -w /src alpine:latest /bin/sh

# Via cairo:
apk add --no-cache py3-cairosvg cairo pango gdk-pixbuf
cairosvg --output-width 128 --output-height 128 -b none /src/megacmd-addon.svg -o icon.png
cairosvg --output-width 200 --output-height 200 -b none /src/megacmd-addon.svg -o logo.png

# Via rsvg-convert
apk add --no-cache rsvg-convert
rsvg-convert -w 128 -h 128 -b none /src/megacmd-addon.svg -o icon.png
rsvg-convert -w 200 -h 200 -b none /src/megacmd-addon.svg -o logo.png
```
