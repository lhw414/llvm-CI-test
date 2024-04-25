#include "test_optimization.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

PreservedAnalyses TestOptimization::run(Function &F, FunctionAnalysisManager &AM) {
    errs() << "Test Optimization Pass Executed on function: " << F.getName() << "\n";
    return PreservedAnalyses::all();
}
