# Batch convert wmv audio

## Purpose

In terms of gaming on Linux, with the recent [Proton-GE](https://github.com/GloriousEggroll/proton-ge-custom)
versions, wmv videos can be played out of the box. However, there are still
games where wmv videos would play, but without audio.

Some games might be able to be fixed by installing wmp11, or using various
scripts like mf-install, mf-installcab...etc. However, for games that videos
can be located in the game folder, one simple solution would be converting
the audios into an open format, so we don't need to deal with those workarounds.

Since only audios need to be re-encoded, the
process should be much faster compared to re-encoding both video + audio,
and no risk of losing original video quality.

Currently, I only test this with Steam Deck, as it is my only Linux gaming
device atm.

# Usage
```
bash batch_convert_wmv_audio.sh $(path to the folder with wmv files)
```

The script would do the following:
1. Create a `wmvbk` folder in the target folder
2. Backup all wmv videos in the folder to `wmvbk` folder
3. Replace the original wmv file paths with new wmvs by `ffmpeg` where
    - Video codec is copied
    - Audio is encoded by Ogg Vorbis with 48000 bitrate.

(Feel free to edit the `ffmpeg` command in the script to serve your needs.)

# Commands for games
## 999020 - Mega Man Zero/ZX Legacy Collection
Tested with `GE-Proton7-43` on Steam Deck.
```sh
bash batch_convert_wmv_audio.sh ~/.local/share/Steam/steamapps/common/MZZXLC/nativePCx64/RZZC/ZX/DATA/vx/
bash batch_convert_wmv_audio.sh ~/.local/share/Steam/steamapps/common/MZZXLC/nativePCx64/RZZC/ZXA/DATA/vx/
```

# Future improvements
- [ ] pipe options to ffmpeg instead of hard coded in script
