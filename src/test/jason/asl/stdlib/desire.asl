/**
 * Test plans for jason internal actions in stdlib
 *
 * Most of examples come from Jason's documentation
 */

{ include("tester_agent.asl") }

!execute_test_plans.

@[atomic,test]
+!test_desire_atomic
    <-
    !assert_false(.desire(go(1,3)));

    /**
     * Add a mock plan for go(X,Y)
     */
    .add_plan({
      +!go(X,Y) <-
          .wait(200); // An arbitrary delay
    }, self, begin);

    // Trigger the mock plan to test desire
    !!go(1,3);
    !assert_true(.desire(go(1,3)));

    /**
     * Trigger another plan that is actually becomes
     * a desire and instantly is fulfilled
     */
    !go(4,6);
    !assert_false(.desire(go(4,6)));

    // Print desires
    .findall(D,.desire(D),L);
    .log(fine,"Desires: ",L);
.

@[test]
+!test_desire_notatomic
    <-
    !assert_false(.desire(go(2,6)));

    /**
     * Add a mock plan for go(X,Y)
     */
    .add_plan({
      +!go(X,Y) <-
          .wait(200); // An arbitrary delay
    }, self, begin);

    // Trigger the mock plan to test desire
    !!go(2,6);
    !assert_true(.desire(go(2,6)));

    /**
     * Trigger another plan that is actually becomes
     * a desire and instantly is fulfilled
     */
    !go(8,12);
    !assert_false(.desire(go(8,12)));
.