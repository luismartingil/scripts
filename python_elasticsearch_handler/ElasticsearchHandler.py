#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
.. module:: ElasticsearchHandler log handler
   :synopsis: Ability to log into ElasticsearchHandler

.. moduleauthor:: Luis Martin Gil <martingil.luis@gmail.com>

"""


import sys
import logging
import logging.handlers
import datetime
import elasticsearch
import elasticsearch.helpers


class ElasticsearchBufferingHandler(logging.handlers.BufferingHandler):

    def __init__(self, host, port, capacity,
                 index, delete_index=False, context=None):

        d = dict(host=host, port=port)

        self.client = elasticsearch.Elasticsearch([d])
        self.index = index
        self.context = context if context else {}

        logging.handlers.BufferingHandler.__init__(self, capacity)

        if delete_index:
            self.client.indices.delete(index=self.index,
                                       ignore=[400, 404])

    def flush(self):
        """ Flushes the buffer using the Elasticsearch connector.
        TODO. Make sure exceptions work well.
        """

        if len(self.buffer) > 0:

            try:

                actions = []

                for record in self.buffer:

                    # Cook the proper record into a bulk action
                    try:
                        msg = record.msg % (record.args if record.args else ())
                    except:
                        msg = str(record.msg)
                    tm = datetime.datetime.utcfromtimestamp(record.created)

                    source = {
                        "@msg": msg,
                        "@timestamp": tm,
                    }
                    source.update(self.context)

                    prefix = '@args.'
                    avoid = ['args', 'module', 'message', 'msg']

                    for k, v in record.__dict__.iteritems():
                        if k not in avoid:
                            source['{0}{1}'.format(prefix, k)] = str(v)

                    action = {
                        "_index": self.index,
                        "_type": record.module,
                        "_source": source,
                    }

                    actions.append(action)

                # Bulk load all the actions at the same time
                elasticsearch.helpers.bulk(self.client, actions)

            except Exception, err:

                msg = 'Error when flushing using Elasticsearch handler. '
                msg += str(err)
                sys.stdout.write(msg)

            self.buffer = []


class ExtraContentAdapter(logging.LoggerAdapter):

    """
    """

    def process(self, msg, kwargs):

        kwargs['extra'] = self.extra
        return msg, kwargs


if __name__ == '__main__':
    pass
