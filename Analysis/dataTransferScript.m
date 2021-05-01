expNum = 1;
for debugNum = 82:89
    newPath1 = sprintf(['E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/'...
        'Analysis/CHPC/20210409 T 230000/executableCode']);
    if ~exist(newPath1,'dir')
        mkdir(newPath1);
    end
    newPath2 = sprintf(['E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/'...
        'Analysis/CHPC/20210409 T 230000/executableCode/Debug_%i'],debugNum);
    if ~exist(newPath2,'dir')
        mkdir(newPath2);
    end
    
    code = sprintf(['C: "C:/Program Files (x86)/WinSCP/WinSCP.exe" /log="C:\\writable\\path\\to\\log\\WinSCP.log" /ini=nul'...
        ' /command "open scp://jbreytenbach:DieWilge%%40869CHPC%%21@scp.chpc.ac.za/'...
        '-hostkey=""ssh-ed25519 255 9aUMDvjkqBLmS2a+8AfIRdoouURVFHlI00bcEKQjVSo="""'...
        '"cd /home/jbreytenbach/lustre/hyperNEAT_MAPElites/executableCode/Debug_%i"'...
        '"lcd ""E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Analysis\\CHPC\\20210409'...
        ' T 230000\\executableCode\\Debug_%i""" "get Champs" "get ExperimentData" "get Populations" "get Species" "exit"'],debugNum,debugNum);
    
    [status,cmdout] = system(code,'-echo')
end

for expNum = 2:10
    for debugNum = 82:89
        newPath1 = sprintf(['E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/'...
            'Analysis/CHPC/20210409 T 230000/executableCode%i'],expNum);
        if ~exist(newPath1,'dir')
            mkdir(newPath1);
        end
        newPath1 = sprintf(['E:/Google Drive/Academics/UCT - MIT/Research/Code/KeepawaySim/'...
            'Analysis/CHPC/20210409 T 230000/executableCode%i/Debug_%i'],expNum,debugNum);
        if ~exist(newPath2,'dir')
            mkdir(newPath2);
        end
        
        code = sprintf(['/log="C:\\writable\\path\\to\\log\\WinSCP.log" /ini=nul'...
            '/command "open scp://jbreytenbach:DieWilge%%40869CHPC%%21@scp.chpc.ac.za/'...
            '-hostkey=""ssh-ed25519 255 9aUMDvjkqBLmS2a+8AfIRdoouURVFHlI00bcEKQjVSo="""'...
            '"cd /home/jbreytenbach/lustre/hyperNEAT_MAPElites/executableCode%i/Debug_%i"'...
            '"lcd ""E:\\Google Drive\\Academics\\UCT - MIT\\Research\\Code\\KeepawaySim\\Analysis\\CHPC\\20210409'...
            'T 230000\\executableCode%i\\Debug_%i""" "get Champs" "get ExperimentData" "get Populations" "get Species" "exit"'],expNum,debugNum,expNum,debugNum);
        
        system(code)
    end
end

