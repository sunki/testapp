worker_processes 2
working_directory '/home/pub/testapp/current'
listen '/tmp/testapp.sock', :backlog => 64
pid '/var/run/testapp.pid'
preload_app true
timeout 60

after_fork do |server, worker|
  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'pub', 'pub'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if APP_ENV == :development
      STDERR.puts "couldn't change user"
    else
      raise e
    end
  end
end
