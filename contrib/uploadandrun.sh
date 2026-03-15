#!/usr/bin/env sh

BIN_USB2SNESCLI="$(which usb2snes-cli)"
[ -z "${BIN_USB2SNESCLI}" ] && echo "${BIN_USB2SNESCLI} not installed got to https://github.com/usb2snes/usb2snes-cli/tree/master"


PARAM_FILE="$1"
[ -z "${PARAM_FILE}" ] && echo "ERR: didnt' recieve file" && exit 1
[ ! -e "${PARAM_FILE}" ] && echo "ERR: file ${PARAM_FILE} doesnt exist" && exit 1
PARAM_DEST="$2"
[ -z "${PARAM_DEST}" ] && echo "ERR: didnt' recieve dest" && exit 1

UPANDRUN_DEVICE_NAME="$(${BIN_USB2SNESCLI} --list-device |grep For |cut -d\" -f2)"
[ -z "$UPANDRUN_DEVICE_NAME" ] && echo "ERR: Failed to get device" && exit 1
"${BIN_USB2SNESCLI}" --device "${UPANDRUN_DEVICE_NAME}" --menu
sleep 1s
"${BIN_USB2SNESCLI}" --device "${UPANDRUN_DEVICE_NAME}" --upload "${PARAM_FILE}" --path "${PARAM_DEST}"
sleep 1s
"${BIN_USB2SNESCLI}" --device "${UPANDRUN_DEVICE_NAME}" --boot "${PARAM_DEST}"


