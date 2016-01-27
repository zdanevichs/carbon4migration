#!/bin/bash
sqlexec "delete from cards"
sqlexec "delete from card_series"
chroot /app/asr_billing/
/etc/init.d/memcached stop
cd /root/
mkdir new_migration
cd new_migration/
mkdir csv_output
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/crb4_csv_export/main.pyc $1 $2
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/card_series.csv.cfg csv_output/card_series.csv migrate_card_series
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/cards.csv.cfg csv_output/cards.csv migrate_cards
python /usr/lib/python2.6/site-python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/ip_pull.csv.cfg csv_output/ip_pull.csv migrate_ippool
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/switch.csv.cfg csv_output/switch.csv migrate_switch
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/nas.csv.cfg csv_output/nas.csv migrate_nas
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/usluga.csv.cfg csv_output/usluga.csv migrate_usluga
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/tariff.csv.cfg csv_output/tariff.csv migrate_tariff
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/tariff_usluga.csv.cfg csv_output/tariff_usluga.csv migrate_tariff_usluga
python /usr/lib/python2.6/site-packages/carbon_migration_scripts/file_client/import_csv.pyc csv_output/abonent.csv.cfg csv_output/abonent.csv migrate_abonents
python /usr/lib/python2.6/site-packages/python_tools/client_fix_scripts/unblock_after_migration.pyc
/etc/init.d/memcached start
