## Propa tools

This repo contains tooling for the lecture Programmierparadigmen SS18, University of Stuttgart.

#### mm
```sh
mm file arg1 arg2 ...
```

The mm script does the following:

- login to your marvin account
- upload given file to marvin
- compile and run on marvin according to the propa guidelines, while showing output locally
- cleanup afterwards

###### Supported filetypes:
- .java
- .hs
- .adb
- .c (c & c++)

Make sure to provide your username (at ~line 8 of script)
```sh
user=myUserName
```

#### Contributing
Please contribute if you find a bug or want to supply additional tooling. 

In case you wrote additional tests, you can share them here.

