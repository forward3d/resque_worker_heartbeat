# resque_worker_heartbeat

This gem extends the Resque worker class to place a 'heartbeat' key in Redis
every X seconds. This allows you to detect workers that have died by being
killed with SIGKILL, or are on machines that have failed without properly
shutting down their workers.

## Usage

Install the gem using Bundler:

    gem 'resque_worker_heartbeat'    

Or by hand:

    gem install resque_worker_heartbeat

You must include the gem into your worker Rakefile, after you've done
`require resque/tasks`:

    require resque/tasks
    require resque_worker_heartbeat

Now when your worker starts, it will start writing heartbeat keys into Redis. It
will do this when it is idle and working on a job.

## About the heartbeat

The worker will write a key containing an empty string into Redis with the following name:

    worker:worker_name:heartbeat

It will set the expiration of the key to `heartbeat_interval_seconds * heartbeats_before_dead`;
more on these below.

You can detect a failed worker by looking at the set key in Redis with the names of all the
known workers in it (`resque:workers`), then looking for heartbeats for each of these worker
names. If a heartbeat key is missing, then the worker is not sending heartbeats any more and
can be considered to be dead.

## Configuring the heartbeat

You can set the environment variables `HEARTBEAT_INTERVAL_SECONDS` and `HEARTBEATS_BEFORE_DEAD` to
configure how often a heartbeat should be sent (in seconds), and how many heartbeats will elapse
without the heartbeat key being touched before it will disappear from Redis.

The defaults are `HEARTBEAT_INTERVAL_SECONDS = 2` and `HEARTBEATS_BEFORE_DEAD = 25`. This means
a worker will send a heartbeat every two seconds, and after 50 seconds without a heartbeat the heartbeat
key will disappear and the worker can be considered dead.

## Warning

### Resque versions

This has only been tested on Resque 1.x; it looks like it should work with the 2.x codebase, but
I haven't tested it.

### Threading

The heartbeat is implemented as a thread inside the worker processes when it starts. This may not
work correctly on JRuby; again, it hasn't been tested.

## Credits

The original version of this gem was called `resque_heartbeat` and was written by
[svenfuchs](https://github.com/svenfuchs). [jonp](https://github.com/jonp)
[forked it](https://github.com/BIAINC/resque-heartbeat) and added logging, per-process
tracking, tests and other bits and bobs. This gem contains code from both with
slight modifications and some documentation. I renamed it so it could be pushed to Rubygems.