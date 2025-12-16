import { withPluginApi } from "discourse/lib/plugin-api";
import TopicVoteColumn from "../components/topic-votes";

// const votingCategories = settings.voting_categories.split("|").map(Number);

// function isVotingCategory() {
//   const currentCategoryId = discovery.category?.id;
//   return (
//     currentCategoryId && votingCategories.some((c) => c === currentCategoryId)
//   );
// }

const TopicVoting = <template>
  <td class="topic-votes">
    <TopicVoteColumn @topic={{@topic}} />
  </td>
</template>;

export default {
  name: "topic-list-voting-column",

  initialize(container) {
    const discovery = container.lookup("service:discovery");

    withPluginApi((api) => {
      api.registerValueTransformer(
        "topic-list-columns",
        ({ value: columns }) => {
          const currentCategory = discovery.category;
          if (currentCategory?.can_vote) {
            columns.add(
              "topic-voting",
              { item: TopicVoting },
              { after: "replies" }
            );
          }
          return columns;
        }
      );

      // api.registerValueTransformer("topic-list-item-mobile-layout", () => {
      //   return false;
      // });
    });
  },
};
