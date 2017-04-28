#! /usr/bin/env python
from cm_api.api_client import ApiResource
import os

cm_host =  os.environ['CM_HOST']
cm_port =  os.environ['CM_PORT']
cm_user =  os.environ['ADMIN_USER']
cm_pass =  os.environ['ADMIN_PASS']
cluster_name =  os.environ['CDH_CLUSTER_NAME']

api = ApiResource(cm_host, cm_port, cm_user, cm_pass)
cluster = api.get_cluster(cluster_name)
cluster.stop().wait()

