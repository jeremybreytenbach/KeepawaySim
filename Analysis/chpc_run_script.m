%{ 
%% Useful resources
    https://www.nas.nasa.gov/hecc/support/kb/lustre-best-practices_226.html
    https://www.hostinger.com/tutorials/ssh/basic-ssh-commands
    http://www.chpc.ac.za
    http://wiki.chpc.ac.za
    https://users.chpc.ac.za/reports/blockeduser_check/
    https://kinsta.com/blog/how-to-use-ssh/
    https://kinsta.com/blog/ssh-commands/
    
    SSH Command	Explanation
    ls      Show directory contents (list the names of files).
    cd      Change Directory.
    mkdir	Create a new folder (directory).
    touch	Create a new file.
    rm      Remove a file.
    cat     Show contents of a file.
    pwd     Show current directory (full path to where you are right now).
    cp      Copy file/folder.
    mv      Move file/folder.
    grep	Search for a specific phrase in file/lines.
    find	Search files and directories.
    vi/nano	Text editors.
    history	Show last 50 used commands.
    clear	Clear the terminal screen.
    tar     Create & Unpack compressed archives.
    wget	Download files from the internet.
    du      Get file size.
%}

%% log in

% for jobs
ssh jbreytenbach@lengau.chpc.ac.za

% for data transfer
ssh jbreytenbach@scp.chpc.ac.za

%% transfer files
scp E:\Google Drive\Academics\UCT - MIT\Research\Code\KeepawaySim\HyperNEAT Keepaway\Sources\KeepAway\bin\Debug\Keepaway.exe jbreytenbach@scp.chpc.ac.za:/mnt/lustre/users/jbreytenbach/hyperNEAT_MAPElites/executableCode/

%% browse to correct directory
cd /mnt/lustre/users/jbreytenbach/hyperNEAT_MAPElites/executableCode/JobScripts/

%% load modules
module load chpc/monos/ex

%% Submit job to scheduler
qsub chpc_job_script.job
% 3428541.sched01

%% Check status of job
qstat -x -f 3428443.sched01
qstat 3428443.sched01 -H

