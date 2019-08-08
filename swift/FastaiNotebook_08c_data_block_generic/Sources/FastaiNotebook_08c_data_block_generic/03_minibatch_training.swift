/*
THIS FILE WAS AUTOGENERATED! DO NOT EDIT!
file to edit: 03_minibatch_training.ipynb

*/



import Path
import TensorFlow

public typealias TI = Tensor<Int32>

public func accuracy(_ output: TF, _ target: TI) -> TF{
    let corrects = TF(output.argmax(squeezingAxis: 1) .== target)
    return corrects.mean()
}

public func batchedRanges(start:Int, end:Int, bs:Int) -> UnfoldSequence<Range<Int>,Int>
{
  return sequence(state: start) { (batchStart) -> Range<Int>? in
    let remaining = end - batchStart
    guard remaining > 0 else { return nil}
    let currentBs = min(bs,remaining)
    let batchEnd = batchStart.advanced(by: currentBs)
    defer {  batchStart = batchEnd  }
    return batchStart ..< batchEnd
  }
}

public struct DataBatch<Inputs: Differentiable & TensorGroup, Labels: TensorGroup>: TensorGroup {
    public var xb: Inputs
    public var yb: Labels
    
    public init(xb: Inputs, yb: Labels){ (self.xb,self.yb) = (xb,yb) }
}

@differentiable(wrt: logits)
public func crossEntropy(_ logits: TF, _ labels: TI) -> TF {
    return softmaxCrossEntropy(logits: logits, labels: labels)
}
