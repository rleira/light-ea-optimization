# Hemi-cube based lighting optimization
## Project for optimizing lighting using matlab ga optimization tool.

## Instructions
1. Copy the content of matlab globaloptim toolbox inside './private' wihtout folder structure i.e. copy '/globaloptim/private' also to '/private'.
2. Locate customized toolbox files to './customizedToolboxFiles' (how you get those files is up to you, those cannot be copyed to this project).
3. Put a copy of the original files (from taken from the globaloptim toolbox) that are the same files that inside './customizedToolboxFiles' so you can keep a backup and restore in case needed.
4. Run ```setCustomToolboxFiles``` so that the './private' folder is updated with the customized files taken from './customizedToolboxFiles'.

## Commands
Run the following command, from the matlab environment, to use the custom GA optimization files:
```setCustomToolboxFiles```
Run the following command, from the matlab environment, to restore the original GA optimization files:
```setOriginalToolboxFiles```
Run the following command, from the matlab environment, to execute the optimization:
```runEA```

### Notes
- Inside the 'customizedToolboxFiles' folder there is a custom implementation of the globaloptim toolbox (some scripts that where modified).
- Inside the 'private' folder all the globaloptim is copied in order to be possible to run it customized. If you need to use an updated globaloptim toolbox just copy all its files to that directory, notice that the files contained in 'globaloptim\private' must be also inside this project's 'private' folder i.e. it will now work if they are under the 'private/private' folder.

### TODO
- Improve way the globaloptim is customized, having the toolbox copied to this project its a WA that should be avoided.