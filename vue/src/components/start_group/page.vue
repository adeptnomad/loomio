<script lang="js">
import Records        from '@/shared/services/records';
import EventBus       from '@/shared/services/event_bus';
import LmoUrlService  from '@/shared/services/lmo_url_service';
import AuthModalMixin from '@/mixins/auth_modal';
import Session        from '@/shared/services/session';
import I18n           from '@/i18n';

import _isEmpty     from 'lodash/isEmpty';

export default {
  mixins: [AuthModalMixin],
  data() {
    return {group: Records.groups.build({description: I18n.t('group_form.new_description_html')})};
  },
  mounted() {
    if (!Session.isSignedIn()) { this.openAuthModal(); }
  }
};
</script>

<template lang="pug">
v-main
  v-container.max-width-800.start-group-page.px-0.px-sm-3
    group-new-form(:group="group")
</template>
