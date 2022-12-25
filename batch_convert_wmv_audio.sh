#!/bin/bash
[ ! -d "$1" ] && echo "$1 isn't a valid path" && exit 1

cd $1
export bk_folder="wmvbk"


# revert backups if presented
if [ -d "$bk_folder" ]; then
    for file in $(ls $bk_folder); do
        mv "$bk_folder/$file" $file
    done
fi

# create backup folder
mkdir -p $bk_folder

for file in $(ls); do
   if [[ $file =~ .*\.(wmv$) ]]; then
        # Move file to backup folder
        mv $file "$bk_folder/"
        # convert file audio and save to original location
        echo "Converting file $file..."
        # it is required to output to mkv otherwise ffmpeg refuses to write
        ffmpeg -i $bk_folder/$file -vcodec copy -acodec libopus -b:a 48000 $file.mkv
        mv $file.mkv $file
   fi
done
echo "All Done!"
