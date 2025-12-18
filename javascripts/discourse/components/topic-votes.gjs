import Component from "@glimmer/component";
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

  get isVotingCategory() {}

  <template>
    {{log this.args.topic}}
    {{#if this.args.topic.can_vote}}
      <div
        class="topic-votes__wrapper
          {{if this.hasVotes '--has-votes'}}
          {{if this.isHot '--is-hot'}}"
        title="{{i18n 'topic_voting.vote_count' count=this.topicVotes}}"
      >

        <span
          class="topic-votes__hot-indicator"
          title="{{i18n 'topic_voting.hot_topic'}}"
        >
        </span>
        {{icon "caret-up"}}
        <span class="topic-votes__count">{{this.topicVotes}}</span>
      </div>
    {{/if}}
  </template>
}
