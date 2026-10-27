URUCHOMIENIE PROJEKTU
__________________________________________________________________
1.WYMAGANIA: 
- System Linux / macOS (lub Windows z WSL2)
- Zainstalowany Docker i Docker Compose  
- Wolne porty na hoscie: 
  * SSH: 1022, 2022, 3022, 4022, 5022
  * HTTP: 2080, 3080, 4080
  * PostgreSQL: 55432
__________________________________________________________________
2.PRZYGOTOWANIE SRODOWISKA: 
  git clone git@github.com:pawelzielinski-it/ansible-ubuntu.git 
  cd ansible-ubuntu 
  ssh-keygen -t rsa -N "" -f "/home/$USER/ansible-ubuntu/id_rsa" -C "$USER"
__________________________________________________________________
3. URUCHOMIENIE KONTENEROW: 
Metoda 1:
  ./setup.sh

Metoda 2: 
  docker compose up -d --force-recreate
__________________________________________________________________
4. POLACZENIE Z KONTROLEREM ANSIBLE: 
Metoda 1:
  ./enter-control.sh  
    
Metoda 2:
  ssh -i id_rsa -p 1022 root@localhost 

Metoda 3:
  docker exec -it control-ctr bash
__________________________________________________________________
5. URUCHOMIENIE AUTOMATYZACJI: 
Metoda 1:
  sh /root/startup.sh 

Metoda 2:
  sh /root/fingerprint.sh
Glowne playbooki znajduja sie w katalogu /etc/ansible/playbooks/:
  ansible-playbook /etc/ansible/playbooks/create_users.yml 
  ansible-playbook /etc/ansible/playbooks/apache.yml 
  ansible-playbook /etc/ansible/playbooks/postgres.yml
__________________________________________________________________
6. MINI PLAYBOOKS (DODATKOWE SKRYPTY)
W folderze /etc/ansible/playbooks/mini_playbooks/ sa proste skrypty do cwiczen:
  check_connection.yml      -> Test polaczenia
  update_upgrade_apt.yml    -> Aktualizuja pakietow systemowych
  install_apt.yml           -> Instaluja narzedzi htop i tree
  delete_apt.yml            -> Usuwanie narzedzi htop i tree
  create_user.yml           -> Tworzy uzytkownika 'admin'
  delete_user.yml           -> Usuwanie uzytkownika 'admin'
  create_directory_file.yml -> Tworzenie katalogu i pliku tekstowego
  bck_directory.yml         -> Tworzenie kopii zapasowej katalogu
  delete_directory.yml      -> Usuwanie katalogu
__________________________________________________________________
PRZYKLAD UZYCIA:
  ansible-playbook /etc/ansible/playbooks/mini_playbooks/check_connection.yml

7. UZYTKOWNICY TWORZENI PRZEZ ANSIBLE
  Kontener | Uzytkownik | Haslo
  app1     | developer1 | Startowe321 
  app2     | developer2 | Startowe321 
  app3     | developer3 | Startowe321 
  db1      | dbuser     | Startowe321 

Przyklad logowania: 
  ssh developer1@app1 
  ssh dbuser@db1
__________________________________________________________________
8. TESTOWANIE USLUG
APACHE:
  http://localhost:2080/ 
  http://localhost:3080/ 
  http://localhost:4080/ 

POSTGRESQL: 
Polacz sie z kontenerem:
  ssh dbuser@db1
  
Wpisz komende: 
  psql -d data 

W konsoli psql: 
  \l – lista baz danych 
  \du – lista uzytkownikow 
  \dn – lista schematow 
  \q – wyjscie
__________________________________________________________________
9. CZYSZCZENIE SRODOWISKA
Metoda 1: 
  ./cleanup.sh
Metoda 2: 
  docker compose down --volumes --rmi all

UWAGA: Projekt ma charakter edukacyjny. W srodowiskach produkcyjnych nigdy nie przechowuje sie kluczy prywatnych w repozytorium ani hasel jawnym tekstem w plikach.
