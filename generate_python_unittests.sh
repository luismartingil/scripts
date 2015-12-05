#!/bin/bash
#
# Finds Python project modules and creates an
# empty unittest skeleton pytest oriented.
#
# Author: luismartingil
# Year: 2015

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pname=myproject
sources_dir=../$pname/
tests_dir=../test

# Leave when anything goes wrong
set -e

qquit_msg ()
{
    echo 'Error. '$1
    exit 1
}

create_unittest_file() {
    test=$1
    package_name=$2
    package_prefix=$3
    package=$3.$2
    echo 'Creating new unittest file "'$1'".'
    cat > $1 <<EOF
#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
.. module:: Tests for \`$package\`.

.. moduleauthor:: Zaleos <developers@zaleos.net>

"""

import pytest
import $package

@pytest.mark.parametrize(
    "input,expected", [
        ('TODO', 'TODO'),
    ]
)
def test_$package_name(input, expected):
    """Testing $module
    """
    assert input != expected

EOF
    echo 'Done.'
}

my_main ()
{

    find $sources_dir -type f -name '*.py' -not -name '__init__.py' -printf '%P\0' |
	while read -d $'\0' i; do
	    package_dirname=$(dirname $i | sed 's/'$pname'\///g' | sed 's/\//./g') ;
	    package_name_complete=$(basename $i)
	    package_name=${package_name_complete%.*}
	    package_prefix=$pname.$package_dirname
	    test_name='test_'$(echo $package_prefix | sed 's/\./_/g')'_'$package_name_complete
	    test=$tests_dir/$test_name
	    if [ -f "$test" ]; then
	        echo 'File "'$test_name'" exists. Not creating.';
	    else
	        echo 'File "'$test_name'" doesnt exist. Creating.';
	        # create_unittest_file $test $package_name $package_prefix
	    fi
	done
    cd $DIR
}

my_main
