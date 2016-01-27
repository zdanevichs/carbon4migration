before start script please run commands:
sqlexec "delete from cards"
sqlexec "delete from card_series"
chroot /app/asr_billing/
/etc/init.d/memcached stop
cd /root/
mkdir new_migration
cd new_migration/
mkdir csv_output
# carbon4migration ip_address password
