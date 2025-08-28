PROJECT = http_server
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0

DEPS = cowboy liver jsx epgsql poolboy

dep_cowboy_commit = 2.13.0
dep_liver = git https://github.com/erlangbureau/liver.git 0.9.0
dep_jsx = git https://github.com/talentdeficit/jsx v3.1.0
dep_epgsql = git https://github.com/epgsql/epgsql 4.6.0
dep_poolboy = git https://github.com/devinus/poolboy 1.5.2

CONFIG = config/http_server.config
RUN_ERL = erl -pa ebin -pa deps/*/ebin -config $(CONFIG) -s $(PROJECT)

include erlang.mk
