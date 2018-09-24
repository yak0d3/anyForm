

# anyForm

> anyForm is a lightweight form brute-forcing tool that can break any form that contains a username and a password fields.

At this time, anyForm is still at early stage development, functionalities are very limited but they are good enough for classical web forms.** 

![anyForm main display - screenshot1](https://preview.ibb.co/d5KLwp/anyform_main_display.png)

# Usage
**anyForm is so plain and simple you only have to pass by a few steps and your brute-force attack is all ready.
Follow these steps to successfully start cracking passwords:**
 1. `$ perl anyform.pl `
 2. `set url <your_form_url>`
 3. `set users <users_list>`
 4. `set passwords <passwords_list>`
 5. `set userField <field_name_from_html_source>`
 6. `set passField <field_name_from_html_source>`
 7. `set ssMsg <success_message_source>`
 8. `start`
![anyForm brute-forcing - Screenshot2](https://image.ibb.co/b4Bpp9/Screenshot_from_2018_09_24_03_34_56.png)

# Commands
**If you need to get more in depth of anyForm here is the list of anyForm commands:**

| Command | Action | Example
|----|----|----|
| set url \<value> | Setting the form url to a new value| set url http://www.example.com/form1.php |
| set users \<value>|  Give users list a new value | set users users_list.txt
|set passwords \<value> | Give passwords list a new value | set passwords passwords_list.txt
| set userField \<value> | Enter the value of the user field (as in the html |set userField username
| set passField \<value> | Enter the value of the password field (as in the |set userField password
|set ssMsg \<value>     | Setting the success string to test on             | set ssMsg success.txt
| start                 | Start brute-forcing                                
| help                  | Show this help message                                                           
|clear|Clear console
|exit| Exit anyForm

## To-Do List:
This version of anyForm is very basic, later version will have better functionalities and trust me, you will **love it**.
*Here is the list of the to-be-added functionalities:*
 - [ ] Auto-Install missing modules.
 - [ ] Add custom form elements.
 - [ ] Proxy connections.
 - [ ] Better interactive interface.
 - [ ] Multi-forms brute-forcing.
 - [ ] Data generator (Users,Passwords,Tokens etc...)
 

## Help Improving anyForm

 Do you have a new idea? Or you think anyForm is missing something? Simply make a new pull request or contact me @ contact.raedyak@gmail.com to suggest changes.

## Report A Bug
An error has occurred and you have no clue what caused it? **Don't panic,** as mentioned above anyForm is still in early stage development, errors and bugs might occur, just make a new issue or contact me @ contact.raedyak@gmail.com for bug report.
# Legal Disclaimer

-   ##### [](https://github.com/yak0d3/dDumper#i-do-not-take-any-responsibility-and-i-am-not-liable-for-any-damage-caused-through-the-use-of-this-product)I do not take any responsibility and I am not liable for any damage caused through the use of this product.
    
-   ##### [](https://github.com/yak0d3/dDumper#i-do-not-take-responsibility-for-any-illegal-usage)I do not take responsibility for any illegal usage.
## License

[![dDump3r MIT License](https://camo.githubusercontent.com/1dc21097eff30becb4aeafd09c8d25a22dd6cb03/68747470733a2f2f696d6167652e6962622e636f2f6446704d484b2f652e706e67)](https://camo.githubusercontent.com/1dc21097eff30becb4aeafd09c8d25a22dd6cb03/68747470733a2f2f696d6167652e6962622e636f2f6446704d484b2f652e706e67)
