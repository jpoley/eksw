rm -rf setup-vpc.yaml 

export MY_IP=`curl http://ipinfo.io/ip`

tee ./setup-vpc.yaml << EOF
AWSTemplateFormatVersion: 2010-09-09

Resources:
  # First, a VPC:
  VPC:
    Type: AWS::EC2::VPC
    Properties:
      CidrBlock: 10.1.0.0/16
      EnableDnsSupport: true
      EnableDnsHostnames: true
      Tags:
        - Key: Name
          Value: !Join ["", [!Ref "AWS::StackName", "-VPC"]]

  # Our VPC will need internet access:
  InternetGateway:
    Type: AWS::EC2::InternetGateway
    DependsOn: VPC
  AttachGateway:
    Type: AWS::EC2::VPCGatewayAttachment
    # Notice how you can't attach an IGW to a VPC unless both are created:
    Properties:
      VpcId: !Ref VPC
      InternetGatewayId: !Ref InternetGateway

  # Now some subnets, 4 public
  PublicSubnetA:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.1.1.0/24
      AvailabilityZone: !Select [0, !GetAZs ] # Get the first AZ in the list
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-Public-A
  PublicSubnetB:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.1.2.0/24
      AvailabilityZone: !Select [1, !GetAZs ] # Get the second AZ in the list
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-Public-B
  PublicSubnetC:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.1.3.0/24
      AvailabilityZone: !Select [2, !GetAZs ] # Get the thrid AZ in the list
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-Public-C
  PublicSubnetD:
    Type: AWS::EC2::Subnet
    Properties:
      VpcId: !Ref VPC
      CidrBlock: 10.1.4.0/24
      AvailabilityZone: !Select [3, !GetAZs ] # Get the forth AZ in the list
      Tags:
        - Key: Name
          Value: !Sub ${AWS::StackName}-Public-D

  # Some route tables for our subnets:
  PublicRouteTable:
    Type: AWS::EC2::RouteTable
    Properties:
      VpcId: !Ref VPC
      Tags:
        - Key: Name
          Value: Public
  PublicRoute1: # Public route table has direct routing to IGW:
    Type: AWS::EC2::Route
    DependsOn: AttachGateway
    Properties:
      RouteTableId: !Ref PublicRouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref InternetGateway

  # Attach the public subnets to public route tables,
  # and attach the private subnets to private route tables:
  PublicSubnetARouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnetA
      RouteTableId: !Ref PublicRouteTable
  PublicSubnetBRouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnetB
      RouteTableId: !Ref PublicRouteTable
  PrivateSubnetARouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnetC
      RouteTableId: !Ref PublicRouteTable
  PrivateSubnetBRouteTableAssociation:
    Type: AWS::EC2::SubnetRouteTableAssociation
    Properties:
      SubnetId: !Ref PublicSubnetD
      RouteTableId: !Ref PublicRouteTable
  InstanceSecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
        GroupDescription: Allow SSH only from my IP
        VpcId:
          Ref: !Ref VPC
        SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: 22
          ToPort: 22
          CidrIp: $MY_IP/32
        SecurityGroupEgress:
        - IpProtocol: any
          CidrIp: 0.0.0.0/0
EOF



aws cloudformation create-stack  --stack-name=aws-pug-vpc  --template-body  file://setup-vpc.yaml --debug