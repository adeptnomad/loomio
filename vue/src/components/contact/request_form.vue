<script lang="js">
import Records  from '@/shared/services/records';
import EventBus from '@/shared/services/event_bus';
import Flash  from '@/shared/services/flash';

export default
{
  props: {
    user: Object
  },
  data() {
    return {contactRequest: Records.contactRequests.build({recipientId: this.user.id})};
  },
  methods: {
    submit() {
      this.contactRequest.save().then(() => {
        Flash.success("contact_request_form.email_sent", {name: this.user.name});
        EventBus.$emit('closeModal')
      });
    }
  }
};

</script>
<template lang="pug">
v-card.contact-user-modal
  v-card-title
    h1.headline(tabindex="-1" v-t="{ path: 'contact_request_form.modal_title', args: { name: user.name }}")
    v-spacer
    dismiss-modal-button
  v-card-text.contact-user-form
    v-textarea.contact-request-form__message(v-model="contactRequest.message", maxlength="500", :label="$t('contact_request_form.message_placeholder')")
    validation-errors(:subject="contactRequest", field="message")
    p(v-t="{ path: 'contact_request_form.helptext', args: { name: user.firstName() }}")
  v-card-actions
    v-spacer
    v-btn.contact-request-form__submit(@click="submit()" v-t="'common.action.send'" color="primary")
</template>
