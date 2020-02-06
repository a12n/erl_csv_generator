REBAR=$(shell which rebar3)

.PHONY: all clean test

all:
	@$(REBAR) compile

edoc:
	@$(REBAR) edoc

test:
	@$(REBAR) eunit

clean:
	@$(REBAR) clean

build_plt:
	@true

dialyzer:
	@$(REBAR) dialyzer
