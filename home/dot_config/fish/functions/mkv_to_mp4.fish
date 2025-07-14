function mkv_to_mp4
    ffmpeg -i $argv[1] -filter:v 'fps=59.99' -vsync cfr -c:a aac -strict experimental $argv[1].mp4
end
