import SortableColumn from "discourse/components/topic-list/header/sortable-column";
import { withPluginApi } from "discourse/lib/plugin-api";
import TopicVoteColumn from "../components/topic-votes";

// const votingCategories = settings.voting_categories.split("|").map(Number);

// function isVotingCategory() {
//   const currentCategoryId = discovery.category?.id;
//   return (
//     currentCategoryId && votingCategories.some((c) => c === currentCategoryId)
//   );
// }

const TopicVotingHeader = <template>
  <SortableColumn
    @sortable={{@sortable}}
    @order="votes"
    @activeOrder={{@activeOrder}}
    @changeSort={{@changeSort}}
    @ascending={{@ascending}}
    @name="topic_voting.vote_title_plural"
  />
</template>;

const TopicVotingItem = <template>
  <td class="topic-votes">
    <TopicVoteColumn @topic={{@topic}} />
  </td>
</template>;

export default {
  name: "topic-list-voting-column",

  initialize(container) {
    const siteSettings = container.lookup("service:site-settings");

    if (!siteSettings.topic_voting_enabled) {
      return;
    }

    const discovery = container.lookup("service:discovery");

    withPluginApi((api) => {
      api.registerValueTransformer(
        "topic-list-columns",
        ({ value: columns }) => {
          const currentCategory = discovery.category;
          if (currentCategory?.can_vote || settings.show_everywhere) {
            columns.add(
              "topic-voting",
              { header: TopicVotingHeader, item: TopicVotingItem },
              { after: "replies" }
            );
          }
          return columns;
        }
      );
    });
  },
};
