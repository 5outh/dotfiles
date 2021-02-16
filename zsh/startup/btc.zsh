#!/bin/zsh

LAST_WEEK=$(date --date="7 days ago" --iso-8601=seconds)
# Get the close price from last 7 days of candles, reverse for in-order
# processing, take only the last 7 days because coinbase's API is stupid and
# will return extra
PRICES=$(http "https://api.pro.coinbase.com/products/BTC-USD/candles?granularity=3600&start=$LAST_WEEK" | jq ".[][4]" | tac | tail -168)

MAX_PRICE=0
MIN_PRICE=100000000
DIFF_PRICE=0

CURRENT_PRICE=

for PRICE in ${=PRICES}; do
  if (( $PRICE > $MAX_PRICE )); then
    MAX_PRICE=$PRICE
  fi

  if (( $PRICE < $MIN_PRICE )); then
    MIN_PRICE=$PRICE
  fi

  CURRENT_PRICE=$PRICE
done

SUM_WEEK=0
PRICES_WEEK=$(echo ${PRICES// /\n} | tail -168)

# Moving average for the last day
for PRICE in ${=PRICES_WEEK}; do
  ((SUM_WEEK = SUM_WEEK + PRICE))
done


AVERAGE_WEEK=$(($SUM_WEEK / 168))
DIFF_PRICE_WEEK=$(($CURRENT_PRICE - $AVERAGE_WEEK))
DIFF_PRICE_PERC_WEEK=$((1 - (100 - (100 * $CURRENT_PRICE / $AVERAGE_WEEK))))

SUM_DAY=0
PRICES_DAY=$(echo ${PRICES// /\n} | tail -24)

# Moving average for the last day
for PRICE in ${=PRICES_DAY}; do
  ((SUM_DAY = SUM_DAY + PRICE))
done


AVERAGE_DAY=$(($SUM_DAY / 24))
DIFF_PRICE_DAY=$(($CURRENT_PRICE - $AVERAGE_DAY))
DIFF_PRICE_PERC_DAY=$((1 - (100 - (100 * $CURRENT_PRICE / $AVERAGE_DAY))))

RESET="\e[0m"
RED="\e[0;31m"
GREEN="\e[0;32m"
BLUE="\u001b[34m"

price() {
  if (($1 <0 )); then
    printf "$RED-$%'0.2f$RESET" $1
  else
    printf "$GREEN$%'0.2f$RESET" $1
  fi
}

diff_price() {
  if (($1 <0 )); then
    printf "$RED$%'0.2f$RESET" $1
  else
    printf "$GREEN+$%'0.2f$RESET" $1
  fi
}

perc() {
  if (($1 <0 )); then
    printf "$RED%'0.2f%%$RESET" $1
  else
    printf "$GREEN+%'0.2f%%$RESET" $1
  fi
}

ticker_link() {
  if (( $DIFF_PRICE_PERC_DAY < 0 )); then
    printf "${GREEN}\e]8;;https://pro.coinbase.com/trade/BTC-USD\e\\Buy BTC\e]8;;\e\\\\"
  elif (( $DIFF_PRICE_PERC_WEEK < 0 )); then
    printf "${GREEN}\e]8;;https://pro.coinbase.com/trade/BTC-USD\e\\Strong Buy BTC\e]8;;\e\\\\"
  elif (( $DIFF_PRICE_PERC_DAY > 10 )); then
    printf "${RED}\e]8;;https://pro.coinbase.com/trade/BTC-USD\e\\Sell BTC\e]8;;\e\\\\"
  else
    printf "${BLUE}\e]8;;https://pro.coinbase.com/trade/BTC-USD\e\\BTC\e]8;;\e\\\\"
  fi
  print $RESET
}

cat <<EOM
$(ticker_link): $(price $CURRENT_PRICE) ($(perc $DIFF_PRICE_PERC_DAY) MA1, $(perc $DIFF_PRICE_PERC_WEEK) MA7)
EOM
