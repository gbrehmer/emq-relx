PROJECT = emq-relx
PROJECT_DESCRIPTION = Release Project for the EMQ Broker
PROJECT_VERSION = 2.3.11-authfix2

## Fix 'rebar command not found'
DEPS = goldrush
dep_goldrush = git https://github.com/basho/goldrush 0.1.9

DEPS += emqttd emq_modules emq_dashboard emqx_retainer emqx_recon emqx_reloader \
        emqx_auth_clientid emqx_auth_username emqx_auth_ldap emqx_auth_http \
        emqx_auth_mysql emqx_auth_pgsql emqx_auth_redis emqx_auth_mongo \
        emqx_sn emqx_coap emqx_stomp emqx_plugin_template emqx_web_hook \
        emqx_lua_hook emqx_auth_jwt

# emq deps
dep_emqttd        = git https://github.com/gbrehmer/emqttd master
dep_emq_modules   = git https://github.com/emqtt/emq-modules master
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard master
dep_emqx_retainer  = git https://github.com/emqx/emqx-retainer master
dep_emqx_recon     = git https://github.com/emqx/emqx-recon master
dep_emqx_reloader  = git https://github.com/emqx/emqx-reloader master

# emq auth/acl plugins
dep_emqx_auth_clientid = git https://github.com/emqx/emqx-auth-clientid master
dep_emqx_auth_username = git https://github.com/emqx/emqx-auth-username master
dep_emqx_auth_ldap     = git https://github.com/emqx/emqx-auth-ldap master
dep_emqx_auth_http     = git https://github.com/emqx/emqx-auth-http master
dep_emqx_auth_mysql    = git https://github.com/emqx/emqx-auth-mysql master
dep_emqx_auth_pgsql    = git https://github.com/emqx/emqx-auth-pgsql master
dep_emqx_auth_redis    = git https://github.com/emqx/emqx-auth-redis master
dep_emqx_auth_mongo    = git https://github.com/emqx/emqx-auth-mongo master
dep_emqx_auth_jwt      = git https://github.com/emqx/emqx-auth-jwt master

# mqtt-sn, coap and stomp
dep_emqx_sn    = git https://github.com/emqx/emqx-sn master
dep_emqx_coap  = git https://github.com/emqx/emqx-coap master
dep_emqx_stomp = git https://github.com/emqx/emqx-stomp master

# plugin template
dep_emqx_plugin_template = git https://github.com/emqx/emqx-plugin-template master

# web_hook lua_hook
dep_emqx_web_hook  = git https://github.com/emqx/emqx-web-hook master
dep_emqx_lua_hook  = git https://github.com/emqx/emqx-lua-hook master
#dep_emqx_elixir_plugin = git  https://github.com/emqx/emqx-elixir-plugin master

# COVER = true

#NO_AUTOPATCH = emqx_elixir_plugin

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "ssl_dist.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins
