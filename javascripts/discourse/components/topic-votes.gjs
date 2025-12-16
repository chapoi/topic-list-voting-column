import Component from "@glimmer/component";
import icon from "discourse/helpers/d-icon";
import { i18n } from "discourse-i18n";

export default class TopicVoteColumn extends Component {
  get topicVotes() {
    return this.args.topic.vote_count;
  }

  <template>{{this.topicVotes}}</template>
}
