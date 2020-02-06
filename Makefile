REBAR=$(shell which rebar3)

.PHONY: all edoc test clean build_plt dialyzer

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
