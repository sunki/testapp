worker_processes 2
working_directory '/home/pub/testapp/current'
listen '/tmp/testapp.sock', :backlog => 64
pid '/var/run/testapp.pid'
preload_app true
timeout 60