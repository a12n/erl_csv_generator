REBAR=$(shell which rebar3 || echo ./rebar3)

.PHONY: all edoc test clean build_plt dialyzer

all: $(REBAR)
	@$(REBAR) compile

edoc: $(REBAR)
	@$(REBAR) edoc

test: $(REBAR)
	@$(REBAR) eunit

clean: $(REBAR)
	@$(REBAR) clean

build_plt:
	@true

dialyzer: $(REBAR)
	@$(REBAR) dialyzer

./rebar3:
	wget "https://github.com/erlang/rebar3/releases/download/3.13.0/rebar3" -O $@-part
	chmod +x $@-part
	mv $@-part $@
