# HomeToPro
HomeToPro is the ultimate windows utility, made to update Windows 10/11 from the Home edition to the Pro edition without any costs!
HomeToPro was created previously by Raku3702, but I completely rewrote the program and added a lot of functionatilities.
# Features
HomeToPro currently has 3 modes:
 - Activator: This mode just activates your Windows version, using slmgr. It just works with Pro editions by now.
 - Upgrader: This mode performs an upgrade from the Home edition to the Pro edition.
 - Upgrader with activator: This is the most complex mode. It upgrades the system and then activates it.
# Download
Right now, you can downlaod HomeToPro in 2 forms
 - Batch file: It is a file that runs HomeToPro directly.
 - Executable file (.exe): It is the same as the Batch file. The batch file is compressed inside the EXE and the EXE copies it to the temp folder and then runs it.
Both offer the same features, it depends on what you prefer.
Most people prefer the Batch file, as you can review the code inside and it is more lightweight than the exe file.
You can download HomeToPro from the Releases page.
# Features that I'm planning to add
In the next upgrade, I plan to add 2 new features.
The first one will be activation for all Windows edition, detecting your current Windows edition and activating it, as currently HomeToPro only activates Pro edition.
The second will be OS detecting. If your system is lower than Windows 10, the program won't work. This way, I can ensure that nobody puts at risk his/her system by running a program that isn't suitable for their OS.
# How does HomeToPro work?
Although you can view the whole source code, I will explain it here so people without basic programming skills will understand it.
It first does a choice to determine what does the user want to do. 
Then, depending on what is chosen in the choice, it performs different actions:
 - Activator: First, it uses slmgr /ipk to install the Windows Pro product key. Then, it uses slmgr /skms to change the activation servers and finally does slmgr /ato to activate Windows.
 - Upgrader: This method is a bit more complex. It uses LicenseManger service and wuauserv service to start the License Manager (SLUI). Then, HomeToPro uses changepk.exe to set the 
             Windows Pro product key, so the update starts. This method only upgrades, it doesn't activate the system.
 - Upgrader with activator: This is the most complex mode. It combines both of the previous methods, and adds some codes it needs to work properly:
   1. First, it disables UAC and ConsentPromptBehaviorAdmin using regedit to avoid UAC prompts after the first reboot.
   2. Then, it creates a directory called HomeToPro located inside the Windows folder. HomeToPro uses this directory to drop there some files it needs.
   3. After that, HomeToPro will write some codes into a file called activator inside HomeToPro folder. This batch file activates Windows.
   4. After compiling the activator, HomeToPro copies the activator to startup so it runs at system startup.
   5. Then, HomeToPro performs the upgrade using the same method as the upgrader.
   6. Now, HomeToPro will reboot the system
   7. After the system boots, the activation process is started. It will use the same method as the activator to activate Windows.
   8. Finally, when the system is activated, it deletes itself, deletes the temporary files created by HomeToPro and reboots the system again. After that reboot, your Home edition is 
      successfully upgraded to Pro and also activated.
# Issues
HomeToPro is currently open source. If you find any issue or have any suggestion, feel free to make a issue. If you rewrote some code and want me to check it, feel free to create an issue.
All the issues in HomeToPro have been listed here.
ISSUE 1:
 - Description: A bug has been discovered in HomeToPro 0.2, which would jump to the next line of code even if the program was meant to close.
 - Steps to repeat: Launch HomeToPro and select any option except exit. You will see how after you press a key, the program continues working instead of closing.
 - Troubleshoot steps: Update to v0.3
 - Additional INFO: I strongly recommend that you stop using v0.2 and download v0.3
