#!/usr/bin/python
# -*- coding: utf-8 -*-

'''
gitlab5.py

Peewee library to talk to the gitlab v5.0 database.
http://www.gitlab.com/

@author:  Luis Martin Gil
@contact: martingil.luis@gmail.com

https://github.com/luismartingil
www.luismartingil.com
'''

from peewee import *

_mydbpass_ = 'todo'
_mydbhost_ = 'todo'
_mydbport_ = 3306
_mydbuser_ = 'todo'

database = MySQLDatabase('gitlabhq', **{'passwd': _mydbpass_, 'host': _mydbhost_, 'port': _mydbport_, 'user': _mydbuser_})

class UnknownFieldType(object):
    pass

class BaseModel(Model):
    class Meta:
        database = database

class Events(BaseModel):
    action = IntegerField(null=True)
    author = IntegerField(null=True, db_column='author_id')
    created_at = DateTimeField()
    data = TextField(null=True)
    project = IntegerField(null=True, db_column='project_id')
    target = IntegerField(null=True, db_column='target_id')
    target_type = CharField(null=True)
    title = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'events'

class Issues(BaseModel):
    assignee = IntegerField(null=True, db_column='assignee_id')
    author = IntegerField(null=True, db_column='author_id')
    branch_name = CharField(null=True)
    created_at = DateTimeField()
    description = TextField(null=True)
    milestone = IntegerField(null=True, db_column='milestone_id')
    position = IntegerField(null=True)
    project = IntegerField(null=True, db_column='project_id')
    state = CharField(null=True)
    title = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'issues'

class Keys(BaseModel):
    created_at = DateTimeField()
    identifier = CharField(null=True)
    key = TextField(null=True)
    project = IntegerField(null=True, db_column='project_id')
    title = CharField(null=True)
    updated_at = DateTimeField()
    user = IntegerField(null=True, db_column='user_id')

    class Meta:
        db_table = 'keys'

class MergeRequests(BaseModel):
    assignee = IntegerField(null=True, db_column='assignee_id')
    author = IntegerField(null=True, db_column='author_id')
    created_at = DateTimeField()
    merge_status = CharField(null=True)
    milestone = IntegerField(null=True, db_column='milestone_id')
    project = IntegerField(db_column='project_id')
    source_branch = CharField()
    st_commits = TextField(null=True)
    st_diffs = TextField(null=True)
    state = CharField(null=True)
    target_branch = CharField()
    title = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'merge_requests'

class Milestones(BaseModel):
    created_at = DateTimeField()
    description = TextField(null=True)
    due_date = DateField(null=True)
    project = IntegerField(db_column='project_id')
    state = CharField(null=True)
    title = CharField()
    updated_at = DateTimeField()

    class Meta:
        db_table = 'milestones'

class Namespaces(BaseModel):
    created_at = DateTimeField()
    description = CharField()
    name = CharField()
    owner = IntegerField(db_column='owner_id')
    path = CharField()
    type = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'namespaces'

class Notes(BaseModel):
    attachment = CharField(null=True)
    author = IntegerField(null=True, db_column='author_id')
    commit = CharField(null=True, db_column='commit_id')
    created_at = DateTimeField()
    line_code = CharField(null=True)
    note = TextField(null=True)
    noteable = IntegerField(null=True, db_column='noteable_id')
    noteable_type = CharField(null=True)
    project = IntegerField(null=True, db_column='project_id')
    updated_at = DateTimeField()

    class Meta:
        db_table = 'notes'

class Projects(BaseModel):
    created_at = DateTimeField()
    creator = IntegerField(null=True, db_column='creator_id')
    default_branch = CharField(null=True)
    description = TextField(null=True)
    issues_enabled = IntegerField()
    issues_tracker = CharField()
    issues_tracker = CharField(null=True, db_column='issues_tracker_id')
    merge_requests_enabled = IntegerField()
    name = CharField(null=True)
    namespace = IntegerField(null=True, db_column='namespace_id')
    path = CharField(null=True)
    public = IntegerField()
    snippets_enabled = IntegerField()
    updated_at = DateTimeField()
    wall_enabled = IntegerField()
    wiki_enabled = IntegerField()

    class Meta:
        db_table = 'projects'

class ProtectedBranches(BaseModel):
    created_at = DateTimeField()
    name = CharField()
    project = IntegerField(db_column='project_id')
    updated_at = DateTimeField()

    class Meta:
        db_table = 'protected_branches'

class SchemaMigrations(BaseModel):
    version = CharField()

    class Meta:
        db_table = 'schema_migrations'

class Services(BaseModel):
    active = IntegerField()
    created_at = DateTimeField()
    project = IntegerField(db_column='project_id')
    project_url = CharField(null=True)
    title = CharField(null=True)
    token = CharField(null=True)
    type = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'services'

class Snippets(BaseModel):
    author = IntegerField(db_column='author_id')
    content = TextField(null=True)
    created_at = DateTimeField()
    expires_at = DateTimeField(null=True)
    file_name = CharField(null=True)
    project = IntegerField(db_column='project_id')
    title = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'snippets'

class Taggings(BaseModel):
    context = CharField(null=True)
    created_at = DateTimeField(null=True)
    tag = IntegerField(null=True, db_column='tag_id')
    taggable = IntegerField(null=True, db_column='taggable_id')
    taggable_type = CharField(null=True)
    tagger = IntegerField(null=True, db_column='tagger_id')
    tagger_type = CharField(null=True)

    class Meta:
        db_table = 'taggings'

class Tags(BaseModel):
    name = CharField(null=True)

    class Meta:
        db_table = 'tags'

class UserTeamProjectRelationships(BaseModel):
    created_at = DateTimeField()
    greatest_access = IntegerField(null=True)
    project = IntegerField(null=True, db_column='project_id')
    updated_at = DateTimeField()
    user_team = IntegerField(null=True, db_column='user_team_id')

    class Meta:
        db_table = 'user_team_project_relationships'

class UserTeamUserRelationships(BaseModel):
    created_at = DateTimeField()
    group_admin = IntegerField(null=True)
    permission = IntegerField(null=True)
    updated_at = DateTimeField()
    user = IntegerField(null=True, db_column='user_id')
    user_team = IntegerField(null=True, db_column='user_team_id')

    class Meta:
        db_table = 'user_team_user_relationships'

class UserTeams(BaseModel):
    created_at = DateTimeField()
    description = CharField()
    name = CharField(null=True)
    owner = IntegerField(null=True, db_column='owner_id')
    path = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'user_teams'

class Users(BaseModel):
    admin = IntegerField()
    authentication_token = CharField(null=True)
    bio = CharField(null=True)
    can_create_group = IntegerField()
    can_create_team = IntegerField()
    color_scheme = IntegerField(db_column='color_scheme_id')
    created_at = DateTimeField()
    current_sign_in_at = DateTimeField(null=True)
    current_sign_in_ip = CharField(null=True)
    email = CharField()
    encrypted_password = CharField()
    extern_uid = CharField(null=True)
    failed_attempts = IntegerField(null=True)
    last_sign_in_at = DateTimeField(null=True)
    last_sign_in_ip = CharField(null=True)
    linkedin = CharField()
    locked_at = DateTimeField(null=True)
    name = CharField(null=True)
    projects_limit = IntegerField(null=True)
    provider = CharField(null=True)
    remember_created_at = DateTimeField(null=True)
    reset_password_sent_at = DateTimeField(null=True)
    reset_password_token = CharField(null=True)
    sign_in_count = IntegerField(null=True)
    skype = CharField()
    state = CharField(null=True)
    theme = IntegerField(db_column='theme_id')
    twitter = CharField()
    updated_at = DateTimeField()
    username = CharField(null=True)

    class Meta:
        db_table = 'users'

class UsersProjects(BaseModel):
    created_at = DateTimeField()
    project_access = IntegerField()
    project = IntegerField(db_column='project_id')
    updated_at = DateTimeField()
    user = IntegerField(db_column='user_id')

    class Meta:
        db_table = 'users_projects'

class WebHooks(BaseModel):
    created_at = DateTimeField()
    project = IntegerField(null=True, db_column='project_id')
    service = IntegerField(null=True, db_column='service_id')
    type = CharField(null=True)
    updated_at = DateTimeField()
    url = CharField(null=True)

    class Meta:
        db_table = 'web_hooks'

class Wikis(BaseModel):
    content = TextField(null=True)
    created_at = DateTimeField()
    project = IntegerField(null=True, db_column='project_id')
    slug = CharField(null=True)
    title = CharField(null=True)
    updated_at = DateTimeField()
    user = IntegerField(null=True, db_column='user_id')

    class Meta:
        db_table = 'wikis'