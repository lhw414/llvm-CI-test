#ifndef TEST_OPTIMIZATION_H
#define TEST_OPTIMIZATION_H

#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"

namespace llvm {
  class TestOptimization : public PassInfoMixin<TestOptimization> {
  public:
      PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
  };
}

#endif // TEST_OPTIMIZATION_H
