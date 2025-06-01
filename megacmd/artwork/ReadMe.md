# Artwork for MEGAcmd Add-on

Building process for creating `png` files from `svg`:

```sh
docker run --rm -it -v .:/src -w /src alpine:latest /bin/sh

apk add --no-cache rsvg-convert
rsvg-convert -w 128 -h 128 -b none /src/megacmd-addon.svg -o icon.png
rsvg-convert -w 200 -h 200 -b none /src/megacmd-addon.svg -o logo.png
```
