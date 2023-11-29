#!/bin/bash
#
#

zfs snapshot catalyst@`date +%Y%m%d_%H%M` && zfs snapshot magellan@`date +%Y%m%d_%H%M`
