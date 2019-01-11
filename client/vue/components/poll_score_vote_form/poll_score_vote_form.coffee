Records  = require 'shared/services/records'
EventBus = require 'shared/services/event_bus'

{ submitStance }  = require 'shared/helpers/form'
{ submitOnEnter } = require 'shared/helpers/keyboard'

module.exports =
  props:
    stance: Object
  data: ->
    vars: {}
  created: ->
    @setStanceChoices()
    EventBus.listen @, 'pollOptionsAdded', @setStanceChoices
  mounted: ->
    submitOnEnter @, element: @$el
  methods:
    stanceChoiceFor: (option) ->
      _.head(_.filter(@stance.stanceChoices(), (choice) =>
        choice.pollOptionId == option.id
        ).concat({score: 0}))

    optionFor: (choice) ->
      Records.pollOptions.find(choice.poll_option_id)

    setStanceChoices: ->
      @stanceChoices = _.map @stance.poll().pollOptions(), (option) =>
        poll_option_id: option.id
        score: @stanceChoiceFor(option).score

    # submit = submitStance $scope, $scope.stance,
    #   prepareFn: ->
    #     EventBus.emit $scope, 'processing'
    #     $scope.stance.id = null
    #     $scope.stance.stanceChoicesAttributes = $scope.stanceChoices
  template:
    """
    <form @submit.prevent="submit()" class="poll-score-vote-form">
      <h3 v-t="'poll_common.your_response'" class="lmo-card-subheading"></h3>
      <ul md-list class="poll-score-vote-form__options">
        <div v-for="choice in stanceChoices" :key="choice.poll_option_id" class="poll-score-vote-form__option">
          <div class="poll-score-vote-form__option-label-container">
            <div class="poll-score-vote-form__option-label">{{ optionFor(choice).name }}</div>
          </div>
          <div md-slider-container class="poll-score-vote-form__input-container">
            <!-- <md-slider min="0" max="9" ng-model="choice.score" aria-label="score" class="poll-score-vote-form__score-slider"></md-slider> -->
            <input type="number" v-model="choice.score" aria-label="score" aria-controls="score-slider" class="poll-score-vote-form__score-input">
          </div>
        </div>
      </ul>
      <validation-errors :subject="stance" field="stanceChoices"></validation-errors>
      <poll-common-stance-reason :stance="stance"></poll-common-stance-reason>
      <div class="poll-common-form-actions lmo-flex lmo-flex__space-between">
        <poll-common-show-results-button v-if="stance.isNew()"></poll-common-show-results-button>
        <div v-if="!stance.isNew()"></div>
        <button type="submit" v-t="'poll_common.vote'" aria-label="$t('poll_poll_vote_form.vote')" class="md-primary md-raised poll-common-vote-form__submit"></button>
      </div>
    </form>
    """
