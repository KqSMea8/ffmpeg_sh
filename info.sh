
echo cqd $1
echo cqd $2
ffprobe -i $1 -show_frames -select_streams v | grep key_frame  > $2 
