#/bin/sh
#******************
# This file is used to generate metadata
# about the kernel which will be embedded
# into the build at compile time.
#******************
CODEFILE="meta.h"
VERSIONFILE="./.b"
STR="const char* ";
INT="int ";

BUILD=../code
OUT=$BUILD/$CODEFILE

AUTHOR_NAME="SharpCoder"
AUTHOR_EMAIL="Josuha@debuggle.com"

KERNEL_NAME="0xrpi Kernel"
KERNEL_NAME_CODE="Mindflayer"
KERNEL_REPO="https://github.com/SharpCoder/rpi-kernel"

MAJOR=0
MINOR=0
BUILD=0

LOGO_WIDTH=30
LOGO_HEIGHT=50
LOGO_TEXT=""

# Check if the build file exists.
if [ -e $VERSIONFILE ]
then
	# If it does exist, load it up.
	BUILD=$(( $(cat $VERSIONFILE) + 1))
else
	# If it does not exist.
	echo "0" > $VERSIONFILE
fi


# Write the new build number to the file.
echo $BUILD > "./.b"

# Finish generating strings.
BUILD_DATE="$(date +%Y-%m-%d)  $(date +%r)"
BUILD_VERSION="$MAJOR.$MINOR.$BUILD"

echo "#ifndef __META_H_" > $OUT
echo "#define __META_H_" >> $OUT
echo "" >> $OUT

echo "struct meta {" >> $OUT
echo "   $STR AUTHOR;" >> $OUT
echo "   $STR EMAIL;" >> $OUT
echo "   $STR KERNEL_NAME;" >> $OUT
echo "   $STR KERNEL_NAME_CODE;" >> $OUT
echo "   $STR KERNEL_REPO;" >> $OUT
echo "   $STR BUILD_DATE;" >> $OUT
echo "   $STR VERSION;" >> $OUT
echo "   $STR LOGO_TEXT;" >> $OUT
echo "   $INT LOGO_WIDTH;" >> $OUT
echo "   $INT LOGO_HEIGHT;" >> $OUT
echo "};" >> $OUT

echo "" >> $OUT
echo "" >> $OUT

echo "static meta getBuildInfo() {" >> $OUT
echo "	meta properties;" >> $OUT
echo "	properties.AUTHOR=\"$AUTHOR_NAME\";" >> $OUT
echo "	properties.EMAIL=\"$AUTHOR_EMAIL\";" >> $OUT
echo "	properties.KERNEL_NAME=\"$KERNEL_NAME\";" >> $OUT
echo "	properties.KERNEL_NAME_CODE=\"$KERNEL_NAME_CODE\";" >> $OUT
echo "	properties.KERNEL_REPO=\"$KERNEL_REPO\";" >> $OUT
echo "	properties.BUILD_DATE=\"$BUILD_DATE\";" >> $OUT
echo "	properties.VERSION=\"$BUILD_VERSION\";" >> $OUT
echo "	properties.LOGO_TEXT=\"$LOGO_TEXT\";" >> $OUT
echo "	properties.LOGO_WIDTH= $LOGO_WIDTH;" >> $OUT
echo "	properties.LOGO_HEIGHT= $LOGO_HEIGHT;" >> $OUT
echo "	return properties;" >> $OUT
echo "}" >> $OUT

echo "" >> $OUT
echo "#endif" >> $OUT
