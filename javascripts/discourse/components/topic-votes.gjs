import Component from "@glimmer/component";
import { and } from "truth-helpers";
import icon from "discourse/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class TopicVoteColumn extends Component {
  get topicVotes() {
    return this.args.topic.vote_count;
  }

  get hasVotes() {
    return this.args.topic.vote_count > 0;
  }

  get isHot() {
    const hotTreshold = parseInt(settings.hot_treshold || "5", 10);
    if (hotTreshold <= 0) {
      return false;
    } else {
      return this.topicVotes >= hotTreshold;
    }
  }

  get hasVoted() {
    return this.args.topic.user_voted;
  }

  <template>
    {{log settings.bells_and_whistles_styling "bells_and_whistles_styling"}}
    {{#if this.args.topic.can_vote}}
      <div
        class="topic-votes__wrapper
          {{if this.hasVotes '--has-votes'}}
          {{if this.isHot '--is-hot'}}"
        title={{i18n "topic_voting.vote_count" count=this.topicVotes}}
      >

        {{#if (and this.hasVoted settings.bells_and_whistles_styling)}}
          <span
            class="topic-votes__voted-icon"
            title={{i18n "topic_voting.user_has_voted"}}
          >
            {{icon "stamp"}}
          </span>
        {{/if}}
        {{icon "caret-up"}}

        <span class="topic-votes__count">{{this.topicVotes}}</span>
      </div>
    {{/if}}
  </template>
}
