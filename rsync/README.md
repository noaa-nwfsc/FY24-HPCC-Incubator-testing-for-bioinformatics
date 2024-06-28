## Copying data from Google Drive to Google Cloud Storage

*This guide was adapted from [Eric Anderson’s chapter](https://eriqande.github.io/eca-bioinf-handbook/working-on-remote-servers.html)*
Install Rclone locally. 
`mamba install rclone -y `
Or download from [here](https://rclone.org/downloads/)
Create a new config 
`rclone config`
You need to create a config for both 
‘Drive’: https://rclone.org/drive/ 
Google cloud storage : https://rclone.org/googlecloudstorage/ 
Make sure you authenticate from your browser. 

Optional, [Encrypt your config](https://eriqande.github.io/eca-bioinf-handbook/working-on-remote-servers.html#encrypting-your-config-file)
You now have a config file at `~/.config/rclone/rclone.conf`. 
You can open and edit this file, or copy it to a remote server as desired. 
To speed up the process, create a section of your config for each root folder you want to copy using the parameter `root_folder_id=’ and set it to the folder ID of your drive folder. This is the string at the end of the folder URL : https://drive.google.com/drive/u/2/folders/<folder id here> 

You can then copy one config section and change the name and folder ID.  
Update your .bashrc (then run ‘source .bashrc’).
Now test your installation 
rclone lsd gsc: 
rclone copy verily-rockfish: gcs:BUCKETNAME/verily-rockfish –dry-run 
Optional: Copy your config to remote location and then copy data 
`rclone copy verily-rockfish: gcs:BUCKETNAME/verily-rockfish` 

