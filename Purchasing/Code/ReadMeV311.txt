Changes to Alliant link process

All generic files are supposed to have the string '         9 000000 000000000' on the first line. Generic files are then bypassed.

All other files for which there is an error are also bypassed. The files with errors as well as the generic files will be listed on the Error Report (which can be archived).

All names of the files with errors (including files with duplicate invoices) but not including the generic files are then saved in a file "ErrFiles.txt" located in the 'ImpErr' subdirectory of the directory holding the Alliant invoice files. For each file name a reason for failure is also given. If required, the info regarding the reason for failure can be made more detailed. Tell me if you want it done.

If an engineer wants to correct one of those files in order to import it all it's needed is for the original file to be opened and edited as desired and then closed. The edited file will then have a new date-time and the next time import is done the file will be picked up for import again. If it fails again its will just appear in the 'ErrFiles.txt' again and another edit can be attempted or you can just give it up.

Of course, files that are wrong and the engineer does not want to correct them need not be deleted as their date time has been passed. Also generic files need not be deleted, the program just reports them and then ignores them.