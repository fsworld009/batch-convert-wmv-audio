#!/bin/bash
set -e

[ ! -d "$1" ] && echo "$1 isn't a valid path" && exit 1

cd $1
export extension=${2:-"wmv"}
export samplerate=${3:-"48000"}
export bk_folder=${4:-"_original"}


# revert backups
if [ -d "$bk_folder" ]; then
    for file in $(ls $bk_folder); do
        mv "$bk_folder/$file" $file
    done
fi

# create backup folder
mkdir -p $bk_folder

for file in $(ls); do
   if [[ $file =~ .*\.($extension$) ]]; then
        # Move file to backup folder
        mv $file "$bk_folder/"
        # convert file audio and save to original location
        echo "Converting file $file..."
        # it is required to output to mkv otherwise ffmpeg refuses to write
        ffmpeg -i $bk_folder/$file -vcodec copy -acodec libopus -b:a $samplerate $file.mkv
        mv $file.mkv $file
   fi
done
echo "All Done!"
