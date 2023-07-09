# Ansible Task Documentation

This document provides instructions for completing the tasks using Ansible.

**Prerequisites**

    > Ansible is installed on your local machine.
    > SSH access to the target Linux machine(s) is available.

**make sure to provide the right server's ip and private key path in inventory file**

**Steps**
### Step 1: Set up Ansible inventory

Create an inventory file (e.g., hosts) and add the IP addresses or hostnames of the target Linux machine(s) under a group name (e.g., [webservers]).

Example inventory file (hosts):



### Step 2: Create an Ansible playbook

Create a playbook file (e.g., lamp.yml) and define the tasks using Ansible modules.

Example playbook file (lamp.yml):



``` 
---
- name: Setup Web Server
  hosts: webservers
  become: true
  tasks:
    - name: Install Apache, MySQL, and PHP
      apt:
        name:
          - apache2
          - mysql-server
          - php
          - libapache2-mod-php
        state: present

    - name: Configure Apache
      template:
        src: apache.conf
        dest: /etc/apache2/sites-available/000-default.conf
        mode: '0644'
      notify: Restart Apache

    - name: Create a simple website
      template:
        src: info.php
        dest: /var/www/html/info.php
        mode: '0644'

    - name: Configure MySQL
      mysql_user:
        name: myuser
        password: mypassword
        login_unix_socket: /var/run/mysqld/mysqld.sock
        priv: "*.*:ALL"
        state: present

    - name: Create MySQL database
      mysql_db:
        name: mydatabase
        state: present

    - name: Modify the website
      template:
        src: info.php
        dest: /var/www/html/info.php
        mode: '0644'

```
### Step 3: Create template files


Example website template (info.php):

php
```
<?php
echo "Hello World!";
?>
```

### Step 4: Run the Ansible playbook

Execute the playbook using the ansible-playbook command. Specify the inventory file and playbook file.

Example command:

plaintext

```
ansible-playbook -i hosts lamp.yml
```
Make sure to replace hosts with the actual name of your inventory file.

That's it! By following these steps, Ansible will automate the installation and configuration of Apache, MySQL, and PHP, as well as the creation of the website and database.

Feel free to adjust the file names and paths to match your project's structure.

Please note that this is a simplified example, and you may need to customize it further based on your specific requirements and environment.

Remember to adjust the file names and paths to match your project's structure.

